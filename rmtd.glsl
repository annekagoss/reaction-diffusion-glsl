#define PI 3.14159265359
#define TAU 6.28318530718
#define CAMERA_POSITION vec3(0.0, 0.0, 2.0)
#define CAMERA_TARGET vec3(0.0, 0.0, 0.0)

#include './raymarch.glsl'

void main() {
    vec2 uv = gl_FragCoord.xy / iResolution.xy;
    Intersect i = rayMarchIntersect(CAMERA_POSITION, CAMERA_TARGET, uv);
    vec4 color = vec4(vec3(0.0), 1.0);
    vec3 distColor = vec3(1.0 - (i.dist - 1.0));
    vec4 fg = vec4(distColor, 1.0);
    if (i.hit) color = fg;
    gl_FragColor = color;
}