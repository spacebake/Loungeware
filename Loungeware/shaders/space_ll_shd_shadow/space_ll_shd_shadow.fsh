varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 shadow_col;

void main()
{
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec4 new = shadow_col;
	new.a = col.a;
	gl_FragColor = new;

}
