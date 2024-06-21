attribute vec3 in_Position;
varying vec3 v_vPosition;

void main()
{
    vec4 pos = vec4(in_Position,0);
	vec4 view = vec4((gm_Matrices[MATRIX_WORLD_VIEW] * pos).xyz,1);
    gl_Position = gm_Matrices[MATRIX_PROJECTION] * view;
	v_vPosition = pos.xyz;
}