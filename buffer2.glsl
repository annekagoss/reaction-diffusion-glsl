#iChannel0 "file://./buffer1.glsl"

#include './common.glsl'

void main() {
    gl_FragColor = rd(iChannel0);
}