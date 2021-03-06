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

    if (iMouse.z > 0.0) {
        vec4 color = texture2D(iChannel0, uv);
        vec2 mo = iMouse.xy / iResolution.xy;
        float mask = step(length(uv-mo), 0.05);
        return mix(color, RED, mask);
    }

    return getLastFrame();
}

void main() {
    gl_FragColor = getColor();
}