// varying vec2 vUv;
uniform float uTime;
uniform float uPositionFrequency;
uniform float uTimeFrequency;
uniform float uStrength;

attribute vec4 tangent;

#include ../includes/simplexNoise4d.glsl

float getWobble(vec3 position) {
    vec3 warpedPosition = position;

    warpedPosition += simplexNoise4d(vec4(
        position,
        uTime
    ));

    return simplexNoise4d(vec4(
        warpedPosition * uPositionFrequency, // XYZ (or rgb)
        uTime // W (or alpha)
    )) * uStrength;
}

void main() {
    vec3 biTangent = cross(normal, tangent.xyz);

    // Neighbours positions
    float shift = 0.01;
    vec3 positionA = csm_Position + tangent.xyz * shift;
    vec3 positionB = csm_Position + biTangent * shift;

    // Wobble
    float wobble = getWobble(csm_Position);
    csm_Position += wobble * normal;
    positionA += getWobble(positionA) * normal; // neighbour A
    positionB += getWobble(positionB) * normal; // neighbour B

    // Compute normal
    vec3 toA = normalize(positionA - csm_Position); // remember to always normalize directions
    vec3 toB = normalize(positionB - csm_Position);
    csm_Normal = cross(toA, toB); // cross product obtained

    // Varyings
    // vUv = uv;
}