#iChannel3 "file://./buffer3.glsl"

#include './common.glsl'

void main() {
    vec2 uv = gl_FragCoord.xy/iResolution.xy;
    vec4 color = texture(iChannel3, uv);
    color = mix(BLACK, WHITE, color.r);
    gl_FragColor = color;
}