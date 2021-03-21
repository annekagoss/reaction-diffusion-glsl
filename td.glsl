#iChannel0 "file://./buffer0.glsl"
#iChannel1 "file://./buffer1.glsl"
#iChannel2 "file://./buffer2.glsl"
#iChannel3 "file://./buffer3.glsl"

#include './common.glsl'

vec4 getLastFrame() {
    vec2 uv = gl_FragCoord.xy/iResolution.xy;
    Settings settings = getSettings();

    if (settings.passes == 1) {

        return texture2D(iChannel0, uv);
    }

    if (settings.passes == 2) {
        return texture2D(iChannel1, uv);
    }

    if (settings.passes == 3) {
        
        return texture2D(iChannel2, uv);
    }
    
    return texture2D(iChannel3, uv);
}

void main() {
    vec4 color = getLastFrame();
    color = mix(BLACK, WHITE, color.r);
    gl_FragColor = color;
}