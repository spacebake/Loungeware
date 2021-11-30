/* Real Fake 3D
 */

/// @desc Sets the origin of the fake 3D world.
/// @desc {real} x The X origin.
/// @desc {real} y The Y origin.
/// @desc {real} z The Z origin.
function katsaii_wandaring_rf3d_set_origin(_x, _y, _z) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var v_p = rf3d.vOff;
    v_p[@ 0] = _x;
    v_p[@ 1] = _y;
    v_p[@ 2] = _z;
}

/// @desc Sets the orientation of the fake 3D world.
/// @desc {real} angle The angle of rotation around the Z-axis.
/// @desc {real} pitch The angle of rotation around the X-axis.
function katsaii_wandaring_rf3d_set_orientation(_angle, _pitch) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var v_x = rf3d.vX;
    var v_y = rf3d.vY;
    var v_z = rf3d.vZ;
    v_x[@ 0] = dcos(_angle);
    var v_x_pitch_radius = dsin(_angle);
    v_x[@ 1] = v_x_pitch_radius * -dcos(_pitch);
    v_x[@ 2] = v_x_pitch_radius * dsin(_pitch);
    v_y[@ 0] = dcos(_angle - 90);
    var v_y_pitch_radius = dsin(_angle - 90);
    v_y[@ 1] = v_y_pitch_radius * -dcos(_pitch);
    v_y[@ 2] = v_y_pitch_radius * dsin(_pitch);
    v_z[@ 0] = 0;
    v_z[@ 1] = dsin(_pitch);
    v_z[@ 2] = dcos(_pitch);
}

/// @desc Draws a debug view of the basis vectors. (Red = X, Green = Y, Blue = Z)
/// @desc {real} x The X position to draw the basis vectors relative to.
/// @desc {real} y The Y position to draw the basis vectors relative to.
/// @desc {real} r The length of the basis vectors.
function katsaii_wandaring_rf3d_draw_debug(_x, _y, _r=20) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var v_x = rf3d.vX;
    var v_y = rf3d.vY;
    var v_z = rf3d.vZ;
    draw_line_colour(_x, _y, _x + _r * v_z[0], _y + _r * v_z[1], c_blue, c_blue);
    draw_line_colour(_x, _y, _x + _r * v_y[0], _y + _r * v_y[1], c_green, c_green);
    draw_line_colour(_x, _y, _x + _r * v_x[0], _y + _r * v_x[1], c_red, c_red);
}

/// @desc Starts a batch with this sprite and image index.
/// @desc {real} sprite The sprite to draw.
/// @desc {real} image The subimage of the sprite to draw.
function katsaii_wandaring_rf3d_draw_begin(_spr, _img) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    rf3d.tex = __katsaii_wandaring_rf3d_get_texture_data(_spr, _img);
    vertex_begin(rf3d.batch, __katsaii_wandaring_rf3d_get_full_fat_vertex_format());
}

/// @desc Ends the current batch and renders it to the screen.
function katsaii_wandaring_rf3d_draw_end() {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var vbuff = rf3d.batch;
    vertex_end(vbuff);
    vertex_submit(vbuff, pr_trianglelist, rf3d.tex.page);
    rf3d.tex = undefined;
}

/// @desc Draws a sprite that always faces the screen.
/// @desc {real} x The X position to draw the billboard sprite at.
/// @desc {real} y The Y position to draw the billboard sprite at.
/// @desc {real} z The Y position to draw the billboard sprite at.
/// @desc {real} [blend] The colour of the billboard sprite.
/// @desc {real} [alpha] The transparency of the billboard sprite.
/// @desc {real} [flip] Whether to flip the billboard uvs.
/// @desc {real} [depth] Manually sets the depth of this image.
function katsaii_wandaring_rf3d_add_billboard(_x, _y, _z, _col=c_white, _alp=1, _flip=false, _depth=0) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var vbuff = rf3d.batch;
    var tex = rf3d.tex;
    var v_pos = rf3d.vOff;
    var v_x = rf3d.vX;
    var v_y = rf3d.vY;
    var v_z = rf3d.vZ;
    _x -= v_pos[0];
    _y -= v_pos[1];
    _z -= v_pos[2];
    var screen_x = floor(_x * v_x[0] + _y * v_y[0] + _z * v_z[0]);
    var screen_y = floor(_x * v_x[1] + _y * v_y[1] + _z * v_z[1]);
    var screen_depth = _x * v_x[2] + _y * v_y[2] + _z * v_z[2] + _depth;
    var screen_depth_top = screen_depth - tex.offY * v_z[2];
    var screen_depth_bottom = screen_depth_top + tex.height * v_z[2];
    if (_flip) {
        var x2 = screen_x + tex.offX;
        var y1 = screen_y - tex.offY;
        var x1 = x2 - tex.width;
        var y2 = y1 + tex.height;
        vertex_position_3d(vbuff, x1, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvTop);
        vertex_position_3d(vbuff, x2, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvTop);
        vertex_position_3d(vbuff, x1, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvBottom);
        vertex_position_3d(vbuff, x1, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvBottom);
        vertex_position_3d(vbuff, x2, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvTop);
        vertex_position_3d(vbuff, x2, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvBottom);
    } else {
        var x1 = screen_x - tex.offX;
        var y1 = screen_y - tex.offY;
        var x2 = x1 + tex.width;
        var y2 = y1 + tex.height;
        vertex_position_3d(vbuff, x1, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvTop);
        vertex_position_3d(vbuff, x2, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvTop);
        vertex_position_3d(vbuff, x1, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvBottom);
        vertex_position_3d(vbuff, x1, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvLeft, tex.uvBottom);
        vertex_position_3d(vbuff, x2, y1, screen_depth_top);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvTop);
        vertex_position_3d(vbuff, x2, y2, screen_depth_bottom);
        vertex_colour(vbuff, _col, _alp);
        vertex_texcoord(vbuff, tex.uvRight, tex.uvBottom);
    }
}

/// @desc Draws a sprite in 3D space. Note: this requires the sprite to have automatic trimming disabled.
/// @desc {real} x1 The X position of the top-left coordinate.
/// @desc {real} y1 The Y position of the top-left coordinate.
/// @desc {real} z1 The Z position of the top-left coordinate.
/// @desc {real} x2 The X position of the top-right coordinate.
/// @desc {real} y2 The Y position of the top-right coordinate.
/// @desc {real} z2 The Z position of the top-right coordinate.
/// @desc {real} x3 The X position of the bottom-right coordinate.
/// @desc {real} y3 The Y position of the bottom-right coordinate.
/// @desc {real} z3 The Z position of the bottom-right coordinate.
/// @desc {real} x4 The X position of the bottom-left coordinate.
/// @desc {real} y4 The Y position of the bottom-left coordinate.
/// @desc {real} z4 The Z position of the bottom-left coordinate.
/// @desc {real} [blend] The colour of the billboard sprite.
/// @desc {real} [alpha] The transparency of the billboard sprite.
function katsaii_wandaring_rf3d_add_sprite_pos(
        _x1, _y1, _z1,
        _x2, _y2, _z2,
        _x3, _y3, _z3,
        _x4, _y4, _z4, _col=c_white, _alp=1) {
    var rf3d = __katsaii_wandaring_rf3d_get_data();
    var vbuff = rf3d.batch;
    var tex = rf3d.tex;
    var v_pos = rf3d.vOff;
    var v_x = rf3d.vX;
    var v_y = rf3d.vY;
    var v_z = rf3d.vZ;
    _x1 -= v_pos[0];
    _y1 -= v_pos[1];
    _z1 -= v_pos[2];
    var x1 = floor(_x1 * v_x[0] + _y1 * v_y[0] + _z1 * v_z[0]);
    var y1 = floor(_x1 * v_x[1] + _y1 * v_y[1] + _z1 * v_z[1]);
    var z1 = _x1 * v_x[2] + _y1 * v_y[2] + _z1 * v_z[2];
    _x2 -= v_pos[0];
    _y2 -= v_pos[1];
    _z2 -= v_pos[2];
    var x2 = floor(_x2 * v_x[0] + _y2 * v_y[0] + _z2 * v_z[0]);
    var y2 = floor(_x2 * v_x[1] + _y2 * v_y[1] + _z2 * v_z[1]);
    var z2 = _x2 * v_x[2] + _y2 * v_y[2] + _z2 * v_z[2];
    _x3 -= v_pos[0];
    _y3 -= v_pos[1];
    _z3 -= v_pos[2];
    var x3 = floor(_x3 * v_x[0] + _y3 * v_y[0] + _z3 * v_z[0]);
    var y3 = floor(_x3 * v_x[1] + _y3 * v_y[1] + _z3 * v_z[1]);
    var z3 = _x3 * v_x[2] + _y3 * v_y[2] + _z3 * v_z[2];
    _x4 -= v_pos[0];
    _y4 -= v_pos[1];
    _z4 -= v_pos[2];
    var x4 = floor(_x4 * v_x[0] + _y4 * v_y[0] + _z4 * v_z[0]);
    var y4 = floor(_x4 * v_x[1] + _y4 * v_y[1] + _z4 * v_z[1]);
    var z4 = _x4 * v_x[2] + _y4 * v_y[2] + _z4 * v_z[2];
    vertex_position_3d(vbuff, x1, y1, z1);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvLeft, tex.uvTop);
    vertex_position_3d(vbuff, x2, y2, z2);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvRight, tex.uvTop);
    vertex_position_3d(vbuff, x4, y4, z4);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvLeft, tex.uvBottom);
    vertex_position_3d(vbuff, x4, y4, z4);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvLeft, tex.uvBottom);
    vertex_position_3d(vbuff, x2, y2, z2);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvRight, tex.uvTop);
    vertex_position_3d(vbuff, x3, y3, z3);
    vertex_colour(vbuff, _col, _alp);
    vertex_texcoord(vbuff, tex.uvRight, tex.uvBottom);
}

/// @desc Returns a reference to the fake 3D controller.
function __katsaii_wandaring_rf3d_get_data() {
    static rf3d = {
        vOff : [0, 0, 0],
        vX : [1, 0, 0],
        vY : [0, 1, 0],
        vZ : [0, 0, 1],
        batch : vertex_create_buffer(),
        tex : undefined,
    };
    return rf3d;
}

/// @desc Packages the sprite information into a single structure.
/// @param {real} sprite The id of the sprite to package.
/// @param {real} subimg The id of the subimage to use.
function __katsaii_wandaring_rf3d_get_texture_data(_sprite, _subimg) {
    var idx_spr = sprite_exists(_sprite) &&
            _subimg >= 0 &&
            _subimg < sprite_get_number(_sprite) ? _sprite : -1;
    var sprite_data = {
        idx : idx_spr,
        img : _subimg,
        offX : 0,
        offY : 0,
        width : 0,
        height : 0,
        page : -1,
        uvLeft : 0,
        uvTop : 0,
        uvRight : 1,
        uvBottom : 1,
    };
    if (idx_spr != -1) {
        var width = sprite_get_width(_sprite);
        var height = sprite_get_height(_sprite);
        var uvs = sprite_get_uvs(_sprite, _subimg);
        var uv_left = uvs[0];
        var uv_top = uvs[1];
        var uv_right = uvs[2];
        var uv_bottom = uvs[3];
        var uv_x_offset = uvs[4]; // number of pixels trimmed from the left
        var uv_y_offset = uvs[5]; // number of pixels trimmed from the top
        var uv_x_ratio = uvs[6]; // ratio of discarded pixels horizontally
        var uv_y_ratio = uvs[7]; // ratio of discarded pixels vertically
        sprite_data.offX = sprite_get_xoffset(_sprite) - uv_x_offset;
        sprite_data.offY = sprite_get_yoffset(_sprite) - uv_y_offset;
        sprite_data.width = width * uv_x_ratio;
        sprite_data.height = height * uv_y_ratio;
        sprite_data.page = sprite_get_info(_sprite).frames[_subimg].texture;
        sprite_data.uvLeft = uv_left;
        sprite_data.uvTop = uv_top;
        sprite_data.uvRight = uv_right;
        sprite_data.uvBottom = uv_bottom;
    }
    return sprite_data;
}

/// @desc Returns the preferred vertex format.
function __katsaii_wandaring_rf3d_get_full_fat_vertex_format() {
    static init = true;
    static format = undefined;
    if (init) {
        init = false;
        vertex_format_begin();
        vertex_format_add_position_3d();
        vertex_format_add_colour();
        vertex_format_add_texcoord();
        format = vertex_format_end();
    }
    return format;
}