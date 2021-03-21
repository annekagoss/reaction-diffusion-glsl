// Based on ReactionDiffusion 3 by aiekick
// https://www.shadertoy.com/view/MlByzR
// http://www.karlsims.com/rd.html

#define WHITE vec4(1.0)
#define BLACK vec4(vec3(0.0), 1.0)
#define RED vec4(1.0, 0.0, 0.0, 1.0)
#define GREEN vec4(0.0, 1.0, 0.0, 1.0)

#include './settings.glsl'

vec2 cell(vec2 offset, float scale, sampler2D channel) {
    vec2 fragCoord = gl_FragCoord.xy;

    if (fragCoord.x + offset.x > iResolution.x) fragCoord.x = 0.;
    if (fragCoord.y + offset.y > iResolution.y) fragCoord.y = 0.;
    if (fragCoord.x + offset.x < 0.0) fragCoord.x = iResolution.x;
    if (fragCoord.y + offset.y < 0.0) fragCoord.y = iResolution.y;

    vec2 uv = (fragCoord.xy + offset) / iResolution.xy;
    return texture(channel, uv).rg * scale;
}

vec2 laplacian2D(sampler2D channel) {
    float st = 1.0;
    float scale = 0.125; // average blurs

    return 
        cell(vec2(0.0, -st), scale, channel) +
        cell(vec2(0.0, st), scale, channel) +
        cell(vec2(st, 0.0), scale, channel) +
        cell(vec2(-st, 0.0), scale, channel) +
        cell(vec2(-st, -st), scale, channel) +
        cell(vec2(-st, st), scale, channel) +
        cell(vec2(st, -st), scale, channel) +
        cell(vec2(st, st), scale, channel) -
        cell(vec2(0.0, 0.0), 1.0, channel);
}

vec4 rd(sampler2D channel) {
    settings = getSettings();

    vec2 ab = cell(vec2(0.0), 1.0, channel);
    vec2 lp = laplacian2D(channel);

    float reaction = ab.x * ab.y * ab.y;
    vec2 diffusion = settings.diffusionCoefficient * lp;

    float feed = settings.feedRate * (1.0 - ab.x);
    float kill = (settings.feedRate + settings.killRate) * ab.y;

    ab += diffusion + vec2(feed - reaction, reaction - kill);

    return vec4(clamp(ab, 0.0, 1e1), 0.0, 1.0);
}