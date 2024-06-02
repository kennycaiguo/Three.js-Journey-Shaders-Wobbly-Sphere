varying vec2 vUv;

void main() {
    // csm_DiffuseColor.rgb = vec3(1.0, 0.5, 0.5); // we use DiffuseColor instead of FragColor because otherwise we would lose the shading
    // csm_Metalness = step(0.0, sin(vUv.x * 100.0 + 0.5)); // easily apply sharp stripes
    // csm_Roughness = 1.0 - csm_Metalness; // makes the stripes transparent
}