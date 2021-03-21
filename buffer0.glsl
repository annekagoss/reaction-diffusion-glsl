#iChannel0 "file://./buffer0.glsl"
#iChannel1 "file://./buffer1.glsl"
#iChannel2 "file://./buffer2.glsl"
#iChannel3 "file://./buffer3.glsl"

#include './common.glsl'

vec4 getLastFrame() {
    Settings settings = getSettings();

    if (settings.passes == 1) {
        return rd(iChannel0);
    }

    if (settings.passes == 2) {
        return rd(iChannel1);
    }

    if (settings.passes == 3) {
        return rd(iChannel2);
    }

    return rd(iChannel3);
}

vec4 getColor() {
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    if (iFrame < 30) {
        float gradient = length(uv - 0.5);
        gradient = (smoothstep(gradient - 0.001, gradient + 0.001, 0.25) - smoothstep(gradient - 0.001, gradient + 0.001, 0.2));
        if (getSettings().invert) gradient = 1.0 - gradient;
        return mix(GREEN, RED, gradient);
    }

    vec4 color = getLastFrame();

    if (iMouse.z > 0.0) {
        vec2 mo = iMouse.xy / iResolution.xy;
        if (length(uv-mo) >= 0.05) return color;
        return mix(GREEN, RED, clamp(length(uv-mo), 0.0, 1.0));
    }

    return color;
}

void main() {
    gl_FragColor = getColor();
}