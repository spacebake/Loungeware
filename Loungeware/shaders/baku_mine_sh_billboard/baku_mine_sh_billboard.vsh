//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{      
    vec3 os_offset = (gm_Matrices[MATRIX_WORLD] * vec4(in_Position.xyz, 0.0)).xyz;
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * vec4(gm_Matrices[MATRIX_WORLD_VIEW][3].xyz + os_offset, 1.0);
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}