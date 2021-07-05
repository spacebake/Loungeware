varying vec2 v_vTexcoord;
varying vec4 v_vColour;



vec4 color_old_primary = vec4(1.0, 0.0, 1.0, 1.0);
vec4 color_old_secondary = vec4(0.0, 0.0, 1.0, 1.0);
uniform vec4 color_new_primary;
uniform vec4 color_new_secondary;

void main()
{
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
	if (col == color_old_primary) {
		col = color_new_primary;
    }
	
	if (col == color_old_secondary) {
		col = color_new_secondary;
    }
    gl_FragColor = col;

}
