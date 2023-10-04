varying vec3 v_vPosition;

#define PI 3.14159265358979
uniform vec4 u_uvs;

void main()
{	
	vec4 uv = u_uvs;
	vec3 r = normalize(v_vPosition)/vec3(uv.zw, 1);
	vec2 u = vec2(atan(r.x, r.y)/2., -asin(r.z))/PI+.5;
    gl_FragColor = texture2D(gm_BaseTexture, (u*uv.zw+uv.xy));
}