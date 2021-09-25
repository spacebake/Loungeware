varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 texel;
uniform vec4 uv;

uniform vec2 split;

uniform float time;

const float TWOPI = 6.28318530718;

void main()
{
	vec2 pos = v_vTexcoord;
	
	// Oscillate
	float moment = pos.y / texel.y;
	
	// Split
	pos.x += (2. * floor(mod(moment, 2.0)) - 1.) * (split.x * texel.x) * sin(TWOPI * moment / split.y + time);
	
	// Wrap
	pos = vec2(mod(pos.x - uv.x, uv.z - uv.x) + uv.x, mod(pos.y - uv.y, uv.w - uv.y) + uv.y);
	
	// Render
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, pos);
}