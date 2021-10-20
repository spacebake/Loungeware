varying vec3 v_vPosition;
varying vec4 v_vColour;
varying vec2 v_vTexcoord;

void main()
{
    gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    bool dissolve = (mod(v_vPosition.x, 2.0) < 1.0) && (mod(v_vPosition.y, 2.0) < 1.0)
            || ((mod(v_vPosition.x + 1.0, 2.0) < 1.0) && (mod(v_vPosition.y + 1.0, 2.0) < 1.0));
    if (dissolve || gl_FragColor.a == 0.0) {
        discard;
    }
}