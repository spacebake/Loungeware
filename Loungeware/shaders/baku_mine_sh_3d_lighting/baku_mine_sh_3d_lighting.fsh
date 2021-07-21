//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 vert_pos;

uniform vec2 room_size;
uniform float highlight_alpha;

#define MAX_LIGHT_COUNT 32
uniform vec4 light_pos[MAX_LIGHT_COUNT]; // x, y, z, w (radius ("wadius, uwu"))
uniform vec4 light_col[MAX_LIGHT_COUNT]; // r, g, b, a

// uniform sampler2D texture_lights;
uniform sampler2D texture_highlight;
uniform sampler2D texture_crack;

void main()
{
    // Base texture
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    // Crack
	vec4 crack_col = texture2D(texture_crack, v_vTexcoord);
	gl_FragColor.rgb = mix(gl_FragColor.rgb, crack_col.rgb, crack_col.a);
	
	// Lights
	// If any shader gods look at this plz don't laugh at me
	float ambient_light = 0.333;
	vec4 light_col_cum = vec4(0.0);
	for (int i = 0; i < MAX_LIGHT_COUNT; ++i) {
		vec4 _light_pos = light_pos[i];
		vec4 _light_col = light_col[i];
		float _distance		= distance(_light_pos.xyz, vert_pos.xyz);
		float _smoothstep	= smoothstep(0.0, _light_pos.w, _distance);
		float _mix			= mix(_light_col.a, 0.0, _smoothstep);
		light_col_cum.rgb	+= _light_col.rgb * vec3(_mix);
		light_col_cum.a		+= _smoothstep;
	}
	light_col_cum /= vec4(MAX_LIGHT_COUNT);
	vec3 final_light_col = gl_FragColor.rgb * (light_col_cum.rgb * vec3(light_col_cum.a));
	gl_FragColor.rgb = mix(final_light_col, gl_FragColor.rgb, ambient_light);
	
	// Highlight
	vec4 highlight_col = texture2D(texture_highlight, v_vTexcoord);
	gl_FragColor.rgb += highlight_col.rgb * vec3(highlight_alpha);
}