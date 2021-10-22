//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 vert_pos;

uniform vec2 room_size;
uniform float crack_img;
uniform float outline_alpha;
uniform float roundabout_active;
uniform vec3 roundabout_col;
uniform vec4 tex_data; // xy = pos on texture page, zw = width/height (yes w = height, it's fucking dumb i know) (all in pixel units)

#define MAX_LIGHT_COUNT 32
uniform vec4 light_pos[MAX_LIGHT_COUNT]; // x, y, z, w (radius ("wadius, uwu"))
uniform vec4 light_col[MAX_LIGHT_COUNT]; // r, g, b, a

uniform sampler2D outline_tex; // fucken hell whyyyyyyyyyyyyyyyy does html gotta be the way it be ;_;

void main()
{
    // General texture stuff
    vec2 texture_page_size = vec2(512.0, 512.0);
    vec2 pixel_size_texels = vec2(1.0 / texture_page_size.x, 1.0 / texture_page_size.y);
    
    // Base texture
    vec2 tex_pos = vec2(tex_data.x * pixel_size_texels.x, tex_data.y * pixel_size_texels.y);
    vec2 tex_size = vec2(tex_data.z * pixel_size_texels.x, tex_data.w * pixel_size_texels.y);
    // vec2 tex_uvs = (v_vTexcoord * tex_size) + tex_pos;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, (v_vTexcoord * tex_size) + tex_pos );
	
	// Crack
    vec2 crack_pos = vec2((64.0 * crack_img) * pixel_size_texels.x, 256.0 * pixel_size_texels.y);
    vec2 crack_size = vec2(64.0 * pixel_size_texels.x, 64.0 * pixel_size_texels.y);
    // vec2 crack_uvs = (v_vTexcoord * crack_size) + crack_pos;
    vec4 crack_col = texture2D( gm_BaseTexture, (v_vTexcoord * crack_size) + crack_pos );
    gl_FragColor.rgb = mix(gl_FragColor.rgb, crack_col.rgb, crack_col.a);
	
	// Lights
	// If any shader gods look at this plz don't laugh at me
	// float ambient_light = 0.333;
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
	gl_FragColor.rgb = mix(final_light_col, gl_FragColor.rgb, 0.333);
	
	// Highlight
    // if (outline_alpha > 0.0) {
	    // vec2 highlight_pos = vec2(384.0 * pixel_size_texels.x, 256.0 * pixel_size_texels.y);
	    // vec2 highlight_pos = pixel_size_texels.xy * vec2(384.0, 256.0);
	    // vec2 highlight_size = vec2(64.0 * pixel_size_texels.x, 64.0 * pixel_size_texels.y);
	    // vec2 highlight_uvs = (v_vTexcoord * crack_size) + highlight_pos;
	    // vec4 highlight_col = texture2D( gm_BaseTexture, (v_vTexcoord * crack_size) + highlight_pos );
    	// gl_FragColor.rgb += highlight_col.rgb * vec3(highlight_alpha_pls_work);
    	// gl_FragColor.rgb += highlight_col.rgb * vec3(0.25);
    	// gl_FragColor.r += highlight_col.r;
    	// gl_FragColor.g += highlight_col.g;
    	// gl_FragColor.b += highlight_col.b;
	    vec4 highlight_col = texture2D( outline_tex, v_vTexcoord );
	    gl_FragColor.rgb += highlight_col.rgb * vec3(0.25);
    // }
	
	// Roundabout overlay
	if (roundabout_active > 0.0) {
		// vec3 luma = ; // Rec. 709
		// float grey_source = dot(gl_FragColor.rgb, vec3(0.2126, 0.7152, 0.0722));
		gl_FragColor.rgb = vec3(dot(gl_FragColor.rgb, vec3(0.2126, 0.7152, 0.0722))) * roundabout_col;
	}
}