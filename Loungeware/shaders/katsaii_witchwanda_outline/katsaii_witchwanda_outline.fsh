varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_outline;
uniform float u_texelW;
uniform float u_texelH;
uniform float u_thickness;

void main()
{
    vec2 offset_x; offset_x.x = u_texelW;
    vec2 offset_y; offset_y.y = u_texelH;
    vec4 pixel_col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    float base_alpha = pixel_col.a;
    float alpha = base_alpha;
    float i;
    for (i = u_thickness; i > 0.0; i--) {
        alpha = max(alpha, texture2D(gm_BaseTexture, v_vTexcoord + i * offset_x).a);
        alpha = max(alpha, texture2D(gm_BaseTexture, v_vTexcoord - i * offset_x).a);
        alpha = max(alpha, texture2D(gm_BaseTexture, v_vTexcoord + i * offset_y).a);
        alpha = max(alpha, texture2D(gm_BaseTexture, v_vTexcoord - i * offset_y).a);
    }
    pixel_col.rgb = base_alpha * pixel_col.rgb + (alpha - base_alpha) * u_outline;
    pixel_col.a = alpha;
    gl_FragColor = pixel_col;
}