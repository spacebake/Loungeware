attribute vec3 in_Position;                 
attribute vec4 in_Colour;                   
attribute vec2 in_TextureCoord;             

varying vec2 v_vTexcoord;
varying vec2 v_vRawCoord;
varying vec4 v_vColour;
varying vec3 vert_pos;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_vColour = in_Colour;
	v_vTexcoord = vec2(in_TextureCoord.x, 1.0 - in_TextureCoord.y); // dammit gamemaker
	v_vRawCoord = in_TextureCoord;
    vert_pos = (gm_Matrices[MATRIX_WORLD] * object_space_pos).xyz;
}