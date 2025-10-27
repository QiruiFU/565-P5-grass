#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4[] in_v0;
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;

layout(location = 0) out float fs_v;
layout(location = 1) out vec3 fs_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 base = in_v0[0].xyz;
    vec3 tip  = in_v1[0].xyz;
    vec3 bend = in_v2[0].xyz;

    float orientation = in_v0[0].w;
    float width = in_v2[0].w;

    vec3 lower = mix(base, tip, v);
    vec3 upper = mix(tip, bend, v);
    vec3 center = mix(lower, upper, v);

    vec3 tangent = normalize(upper - lower);
    vec3 sideDir = normalize(vec3(-cos(orientation), 0.0, sin(orientation)));

    vec3 leftEdge  = center - width * sideDir;
    vec3 rightEdge = center + width * sideDir;

    float t = u + 0.5 * v - u * v;
    vec3 pos = mix(leftEdge, rightEdge, t);

    fs_v = v;
    fs_nor = normalize(cross(tangent, sideDir));

    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
