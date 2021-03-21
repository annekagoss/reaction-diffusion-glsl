#iChannel0 "file://./buffer0.glsl"

#include './common.glsl'

void main() {
    vec2 uv = gl_FragCoord.xy/iResolution.xy;
    vec4 color = texture(iChannel0, uv);
    color = mix(BLACK, WHITE, color.r);
    gl_FragColor = color;
}