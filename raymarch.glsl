#define EPSILON 0.0001
#define MAX_DIST 32.0

#include './sdf.glsl'

struct Intersect {
  float dist;
  bool hit;
};

mat3 initCameraMatrix(vec3 position, vec3 target, float rotation) {
  float f = 1.0;
  vec3 zDirection = normalize(position - target);
  vec3 zAxisRotation = vec3(sin(rotation), cos(rotation), 0.0);
  vec3 xDirection = normalize(cross(zDirection, zAxisRotation)) * f;
  vec3 yDirection = normalize(cross(xDirection, zDirection)) * f;
  mat3 m = mat3(xDirection, yDirection, -zDirection);

  return m;
}

Intersect rayMarch(vec3 rayOrigin, vec3 rayDirection) {
  float dist = 0.0;
  bool hit = false;
  vec3 position = rayOrigin + rayDirection * dist;

  // Step along ray
  for (int i = 0; i < 128; i++) {
    float scene = sceneSDF(position);

    // The distance between the current position and an object is negligible.
    if (scene < EPSILON) hit = true;

    // Flew off into the distance without hitting anything
    if (dist > MAX_DIST)
      break;

    dist += scene;

    // Step further down the ray
    position = rayOrigin + rayDirection * dist;
  }

  return Intersect(dist, hit);
}

vec3 calcRayDirection(vec3 cameraPosition, vec3 cameraTarget, vec2 st) {
    vec2 pixelPosition = (2.0 * gl_FragCoord.xy - iResolution.xy) / iResolution.y;
    mat3 cameraMatrix = initCameraMatrix(cameraPosition, cameraTarget, 0.0);
    return normalize(cameraMatrix * vec3(pixelPosition, 1.0));
}

vec3 calculateNormal(vec3 position) {
    vec3 epsilon = vec3(0.001, 0.0, 0.0);
    return normalize(vec3(
        sceneSDF(position + epsilon.xyy) - sceneSDF(position - epsilon.xyy),
        sceneSDF(position + epsilon.yxy) - sceneSDF(position - epsilon.yxy),
        sceneSDF(position + epsilon.yyx) - sceneSDF(position - epsilon.yyx)
    ));
}

Intersect rayMarchIntersect(vec3 cameraPosition, vec3 cameraTarget, vec2 st) {
    vec3 rayDirection = calcRayDirection(cameraPosition, cameraTarget, st);
    return rayMarch(cameraPosition, rayDirection);
}