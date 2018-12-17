#version 130

uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;

out vec3 pos;
out vec3 normal;
out mat3 TBN;

void main() {
    mat4 modelMatrix = gl_ModelViewMatrix;
    mat4 modelViewMatrix = viewMatrix * modelMatrix;
    mat4 modelViewProjectionMatrix =  projectionMatrix * modelViewMatrix;

    pos = (modelViewMatrix * gl_Vertex).xyz;
    normal = mat3(viewMatrix) * gl_NormalMatrix * gl_Normal;

    // Normal maps are built in tangent space, interpolating the vertex normal and a RGB texture.
    // TBN is the conversion matrix between Tangent Space -> World Space.
    vec3 n = normalize(normal);
    vec3 t = cross(n, vec3(-1,0,0));
    vec3 b = cross(n, t) + cross(t, n);
    TBN = mat3(t, b, n);

    gl_Position = modelViewProjectionMatrix * gl_Vertex;
    gl_TexCoord[0] = gl_MultiTexCoord0;
}
