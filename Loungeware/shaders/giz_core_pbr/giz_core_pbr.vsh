attribute vec3	in_Position;   
attribute vec3	in_Normal;     
attribute vec2	in_TextureCoord;
attribute vec4	in_Tangent;

varying vec2	v_UV;
varying vec3	v_Position;
varying mat3	v_TBN;
varying float	v_vRim;
varying vec3	v_vEyeVec;
varying vec3	v_Normal;

void main()
{	
	vec4 opos = vec4( in_Position, 1.0);
    vec4 onrm = vec4( in_Normal, 0.0 );
    vec4 otan = vec4( in_Tangent.xyz * 2.0 - 1.0, 0.0 );
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vec4( in_Position, 1.0);
    v_Position = vec3( gm_Matrices[ MATRIX_WORLD ] * opos );
    v_UV = in_TextureCoord;
	
    mat3 mat = mat3(gm_Matrices[MATRIX_WORLD]);
    vec3 nrm = normalize( mat * vec3(onrm) );
    vec3 tgn = -normalize( mat * vec3(otan) );
    vec3 bit = normalize( cross( tgn, nrm ) );
	vec3 camPos = - (gm_Matrices[MATRIX_VIEW][3] * gm_Matrices[MATRIX_VIEW]).xyz;
	
	v_vEyeVec	= v_Position - camPos;
    v_TBN		= mat3( tgn, bit, nrm );
	v_Normal	= normalize((gm_Matrices[MATRIX_WORLD] * onrm).xyz);
	v_vRim		= normalize((gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * onrm).xyz).z;
}
