//
// baku's fancy pixel outline shader funhouse extravaganza galore
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float pixel_w;
uniform float pixel_h;
// uniform float sprite_alpha;
// uniform float outline_alpha;
// uniform vec3 outline_colour;
// uniform int sharp_corners;

void main() {
    // Offsets (straight)
    vec2 offset_x;
    offset_x.x = pixel_w;
    vec2 offset_y;
    offset_y.y = pixel_h;
    
    // Alpha
    float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
    
    // Whether current pixel is outline or sprite
    int pixel_is_outline;
    if ( alpha == 0.0 ) {
        pixel_is_outline = 1;
    }
    
    // Increase alpha based on neighbour pixels
    // if ( sharp_corners >= 1 ) {
        // Sharp corners ("square brush")
        // ┌─┬─┬─┬─┐
        // ├─╔═╦═╗─┤
        // ├─╠═╬═╣─┤
        // ├─╚═╩═╝─┤
        // └─┴─┴─┴─┘
        
        // Offsets (diagonal)
        vec2 offset_plus;
        offset_plus.x = pixel_w;
        offset_plus.y = pixel_h;
        vec2 offset_minus;
        offset_minus.x = pixel_w * -1.0;
        offset_minus.y = pixel_h;
        
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_x ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_x ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_y ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_y ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_plus ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_plus ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_minus ).a );
        alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_minus ).a );
    // } else {
    //     // No sharp corners ("round brush")
    //     //   ┌─┬─┐
    //     // ┌─╔═╦═╗─┐
    //     // ├─╠═╬═╣─┤
    //     // └─╚═╩═╝─┘
    //     //   └─┴─┘
        
    //     alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_x ).a );
    //     alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_x ).a );
    //     alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord + offset_y ).a );
    //     alpha += ceil( texture2D( gm_BaseTexture, v_vTexcoord - offset_y ).a );
    // }
    
    // Clamp alpha
    alpha = clamp( alpha, 0.0, 1.0 );
    
    // Draw pixel
    if ( pixel_is_outline == 1 ) {
        // Pixel is part of Outline
        // gl_FragColor.r = outline_colour.x;
        // gl_FragColor.g = outline_colour.y;
        // gl_FragColor.b = outline_colour.z;
        // gl_FragColor.a = outline_alpha * alpha;
        gl_FragColor = vec4(0.0, 0.0, 0.0, alpha);
    } else {
        // Pixel is part of Sprite (not outline)
        gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
        // gl_FragColor.a = sprite_alpha * alpha;
        gl_FragColor.a = alpha;
    }
}