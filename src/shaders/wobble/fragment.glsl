// varying vec2 vUv;
uniform vec3 uColorA;
uniform vec3 uColorB;

varying float vWobble;

void main() {
    // csm_DiffuseColor.rgb = vec3(1.0, 0.5, 0.5); // we use DiffuseColor instead of FragColor because otherwise we would lose the shading
    // csm_Metalness = step(0.0, sin(vUv.x * 100.0 + 0.5)); // easily apply sharp stripes
    // csm_Roughness = 1.0 - csm_Metalness; // makes the stripes transparent

    float colorMix = smoothstep(- 1.0, 1.0, vWobble);
    csm_DiffuseColor.rgb = mix(uColorA, uColorB, colorMix);

    // Mirror step
    csm_Metalness = step(0.25, vWobble); // below 0.25, we get 0, above 0.25, we get 1
    csm_Roughness = 1.0 - csm_Metalness;
}