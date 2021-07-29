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

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    // Lights
	// vec2 lights_uv = vert_pos.xy / room_size;
	// lights_uv = clamp(lights_uv, 0.0, 1.0);
	// vec4 lights_col = texture2D(texture_lights, lights_uv);
	// lights_col.rgb += vec3(0.25); // Ambient dark level
	// lights_col.rgb = clamp(lights_col.rgb, 0.0, 1.0);
	// float lights_glow_start = 32.0;
	// float lights_glow_end = 0.0;
	// float lights_col_value = mix(1.0, 0.0, smoothstep(lights_glow_start, lights_glow_end, distance(vert_pos.z, vert_pos.z ) ) );
	// float dark_col = 0.0; // Ambient dark level
	// gl_FragColor.rgb *= mix(lights_col.rgb, vec3(dark_col), lights_col_value);
	
	// Loop through and calculate light stuff very crudely
	// If anyone is a shader god and looks at this, please don't confront me about how stupid this is ok thx
	vec4 light_ambient = vec4(0.25, 0.25, 0.25, 1.0);
	vec4 light_col_cum = vec4(0.0);
	for (int i = 0; i < MAX_LIGHT_COUNT; ++i) {
		// Get values from arrays cause GM is mad at me for using dot operator on arrays????? the fuck
		vec4 _light_pos = light_pos[i];
		vec4 _light_col = light_col[i];
		
		// Light's alpha at current position
		// float light_new_alpha = mix(_light_col.a, 0.0, smoothstep(_light_pos.w, 0.0, distance(_light_pos.xyz, vert_pos.xyz)));
		float _distance		= distance(_light_pos.xyz, vert_pos.xyz);
		float _smoothstep	= smoothstep(0.0, _light_pos.w, _distance);
		// float _smoothstep	= float(_light_pos.w < _distance);
		float _mix			= mix(_light_col.a, 0.0, _smoothstep);
		
		// Add colour
		light_col_cum.rgb	+= _light_col.rgb * vec3(_mix);
		light_col_cum.a		+= _smoothstep;
	}
	light_col_cum /= vec4(MAX_LIGHT_COUNT);
	// light_col_cum = clamp(light_col_cum, vec4(0.0), vec4(1.0));
	vec3 final_light_col = gl_FragColor.rgb * (light_col_cum.rgb * vec3(light_col_cum.a));
	gl_FragColor.rgb = mix(final_light_col, gl_FragColor.rgb, 0.25); // <-- that lil float is our ambient light level
	
	
	// Highlight
	vec4 highlight_col = texture2D(texture_highlight, v_vTexcoord);
	gl_FragColor.rgb += highlight_col.rgb * vec3(highlight_alpha);
}