#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in float fs_v;
layout(location = 1) in vec3 fs_nor;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    vec3 rootCol = vec3(35.0, 82.0, 47.0) / 255.0;
    vec3 tipCol = vec3(110.0, 212.0, 137.0) / 255.0;
    vec3 baseCol = mix(rootCol, tipCol, fs_v);
    outColor = vec4(baseCol, 1.0);
}
