
#iChannel0 "file://./td.glsl"

float sphereSDF(vec3 pos, float radius) {
    return length(pos) - radius;
}

vec2 getUV(vec3 pos) {
    float textureFreq = 0.3;
    vec2 uv = pos.xy + 0.5;
    uv.x = 1.0 - uv.x;
    
    uv -= vec2(0.5);
    uv *= textureFreq;
    uv += vec2(0.5);
    uv = fract(uv);
    return uv;
}


float sceneSDF(vec3 pos) {
    vec2 uv = getUV(pos);
    vec4 texture = texture(iChannel0, uv);
    pos *= mix(1.0, 1.1, texture.r);
    return sphereSDF(pos, 1.0);
}