//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float roundabout_active;
uniform vec3 roundabout_col;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
	// Roundabout overlay
	if (roundabout_active > 0.0) {
		vec3 luma = vec3(0.2126, 0.7152, 0.0722); // Rec. 709
		float grey_source = dot(gl_FragColor.rgb, luma);
		gl_FragColor.rgb = vec3(grey_source) * roundabout_col;
	}
}
