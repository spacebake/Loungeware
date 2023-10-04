varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D s_metallic;
uniform sampler2D s_roughness;

uniform vec4 u_metallic_uvs;
uniform vec4 u_roughness_uvs;

uniform float u_metalness;
uniform float u_roughness;

float calculate_color(vec4 color){
	return (color.r + color.g + color.b)/3.;	
}
vec2 calculate_uvs(vec4 inUvs){
	return vec2(v_vTexcoord*inUvs.zw+inUvs.xy);	
}
void main()
{
	float r = calculate_color(texture2D( gm_BaseTexture, v_vTexcoord));
	float g = calculate_color(texture2D( s_roughness,	calculate_uvs(u_roughness_uvs)))*u_roughness;
	float b = calculate_color(texture2D( s_metallic,	calculate_uvs(u_metallic_uvs)))*u_metalness;
	gl_FragColor = vec4(r, g, b, 1);
	
}
