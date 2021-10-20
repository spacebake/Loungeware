varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = texture2D(gm_BaseTexture, v_vTexcoord);
    if (gl_FragColor.x == gl_FragColor.y && gl_FragColor.y == gl_FragColor.z) {
        gl_FragColor *= v_vColour;
    }
    if (gl_FragColor.a == 0.0) {
        discard;
    }
}
