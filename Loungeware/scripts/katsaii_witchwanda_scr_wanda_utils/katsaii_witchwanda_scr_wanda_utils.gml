/* Witch Wanda Utilities
 */

#macro KATSAII_WITCH_WANDA_VIEW_CAM (CAMERA)
#macro KATSAII_WITCH_WANDA_VIEW_LEFT (VIEW_X)
#macro KATSAII_WITCH_WANDA_VIEW_TOP (VIEW_Y)
#macro KATSAII_WITCH_WANDA_VIEW_WIDTH (VIEW_W)
#macro KATSAII_WITCH_WANDA_VIEW_HEIGHT (VIEW_H)
#macro KATSAII_WITCH_WANDA_VIEW_RIGHT (KATSAII_WITCH_WANDA_VIEW_LEFT + KATSAII_WITCH_WANDA_VIEW_WIDTH)
#macro KATSAII_WITCH_WANDA_VIEW_BOTTOM (KATSAII_WITCH_WANDA_VIEW_TOP + KATSAII_WITCH_WANDA_VIEW_HEIGHT)
#macro KATSAII_WITCH_WANDA_VIEW_CENTRE_X (KATSAII_WITCH_WANDA_VIEW_LEFT + KATSAII_WITCH_WANDA_VIEW_WIDTH / 2)
#macro KATSAII_WITCH_WANDA_VIEW_CENTRE_Y (KATSAII_WITCH_WANDA_VIEW_TOP + KATSAII_WITCH_WANDA_VIEW_HEIGHT / 2)

/// @desc Outline effect.
/// @param {Real} texel_w The width of a texel.
/// @param {Real} texel_h The height of a texel.
/// @param {Real} colour The colour of the outline.
function katsaii_witchwanda_shader_set_effect_outline(_texel_w, _texel_h, _outline) {
    static u_outline = shader_get_uniform(katsaii_witchwanda_outline_fast, "u_outline");
    static u_texel_w = shader_get_uniform(katsaii_witchwanda_outline_fast, "u_texelW");
    static u_texel_h = shader_get_uniform(katsaii_witchwanda_outline_fast, "u_texelH");
    if (shader_is_compiled(katsaii_witchwanda_outline_fast)) {
        shader_set(katsaii_witchwanda_outline_fast);
        shader_set_uniform_f(u_outline,
                color_get_red(_outline) / 255,
                color_get_green(_outline) / 255,
                color_get_blue(_outline) / 255);
        shader_set_uniform_f(u_texel_w, _texel_w);
        shader_set_uniform_f(u_texel_h, _texel_h);
    }
}

/// @desc Draws a witch.
/// @param {real} witch_sprite The sprite index of the witch to draw.
/// @param {real} witch_image The image index of the witch to draw.
/// @param {real} broom_sprite The sprite index of the broom to draw.
/// @param {real} broom_image The image index of the broom to draw.
/// @param {real} x The x position to draw the witch at.
/// @param {real} y The y position to draw the witch at.
/// @param {real} xscale The x scale of the witch.
/// @param {real} yscale The y scale of the witch.
/// @param {real} colour The colour of the witch.
/// @param {real} alpha The transparency of the witch.
/// @param {real} [dx] The x speed of the witch.
/// @param {real} [dy] The y speed of the witch.
function katsaii_witchwanda_draw_witch(_witch_spr, _witch_img, _broom_spr, _broom_img, _x, _y, _xscale, _yscale, _colour, _alpha, _dx=0, _dy=0) {
    var angle = 5 * -(_dx * sign(_yscale) + _dy * sign(_xscale));
    draw_sprite_ext(_broom_spr, _broom_img, _x, _y, _xscale, _yscale, angle, _colour, _alpha);
    draw_sprite_ext(_witch_spr, _witch_img, _x, _y, _xscale, _yscale, 0.5 * -angle, _colour, _alpha);
}

/*/// @desc Computes the direction from two key presses.
/// @param {real} key_min The key to check to decelerate.
/// @param {real} key_max The key to check to accelerate.
function katsaii_witchwanda_keyboard_direction(_key_min, _key_max) {
    return keyboard_check(_key_max) - keyboard_check(_key_min);
}*/

/// @desc Returns possible difficulty levels.
function katsaii_witchwanda_get_difficulty_levels() {
    static levels = [
        2, JamCBlue.INCOGNITO_GREEN, "TRIVIAL", c_white,
        4, JamCGreen.GOBLIN, "VERY EASY", c_white,
        4, JamCGreen.GRASS, "EASY", c_white,
        8, 0x7EDEF8, "NORMAL", c_black,
        8, c_orange, "HARD", c_black,
        8, JamCPink.LILY, "VERY HARD", c_white,
        10, JamCPink.RUBY, "INSANE", c_white,
        10, JamCPurple.MARDI_GRAS, "IMPOSSIBLE", c_white,
        5, JamCRed.FORREST_FIRE, "WANDAFUL", c_white
    ];
    return levels;
}

/// @desc Maps a number from one range to another.
/// @param {real} value The value to map.
/// @param {real} min1 The minimum bound of the source range.
/// @param {real} max1 The maximum bound of the source range.
/// @param {real} min2 The minimum bound of the destination range.
/// @param {real} max2 The maximum bound of the destination range.
function katsaii_witchwanda_map_range(_value, _min1, _max1, _min2, _max2) {
	var dx = _max1 - _min1;
	var dy = _max2 - _min2;
	return dx == 0 ? NaN : (_value - _min1) / dx * dy + _min2;
}

/// @desc Updates a movement scalar.
/// @param {real} prev_x The current speed.
/// @param {real} acc The acceleration.
/// @param {real} frict The friction coefficient.
/// @param {real} handling The handling coefficient.
/// @param {real} dir The direction of movement.
function katsaii_witchwanda_movement_iterate(_prev_x, _acc, _frict, _handling, _dir) {
    var new_x;
    if (_dir == 0) {
        var prev_sign = sign(_prev_x);
        new_x = _prev_x - prev_sign * _acc * 0.5;
        if (prev_sign != sign(new_x)) {
            new_x = 0;
        }
    } else {
        var dx = _acc * _dir * (sign(_prev_x) != sign(_dir) ? _handling : 1);
        var valid_movement = 1 - abs(2 * arctan(_frict * _prev_x) / pi);
        new_x = _prev_x + dx * valid_movement;
    }
    return new_x;
}

/// @desc Spawns a particle at the current position.
/// @param {real} sys The ID of the particle system to use.
function katsaii_witchwanda_wanda_spawn_particles(_sys) {
    static init = true;
    static ty = __WORKSPACE_PART_TYPE_CREATE(); // hi space :)
    if (init) {
        init = false;
        part_type_shape(ty, pt_shape_disk);
        part_type_life(ty, 15, 60);
        part_type_direction(ty, 0, 360, 0, 5.08);
        part_type_speed(ty, 0, 0.2, 0.02, 0.05);
        part_type_size(ty, 0.01, 0.05, 0.002, 0.005);
        part_type_alpha3(ty, 1, 1, 0);
        part_type_colour3(ty, JamCYellow.REKINDLED, JamCPink.WILD_STRAWBERRY, JamCRed.FORREST_FIRE);
        part_type_gravity(ty, 0.1, 180);
    }
    part_particles_create(_sys, x - 10, y, ty, 1);
}

/// @desc Spawns a particle at the current position.
/// @param {real} sys The ID of the particle system to use.
/// @param {real} sys The ID of the particle system to use.
function katsaii_witchwanda_wanda_enemy_spawn_particles(_sys) {
    static init = true;
    static ty = __WORKSPACE_PART_TYPE_CREATE(); // hi space :)
    if (init) {
        init = false;
        part_type_shape(ty, pt_shape_star);
        part_type_life(ty, 10, 20);
        part_type_direction(ty, 0, 360, 0, 5.08);
        part_type_speed(ty, 0, 0.2, 0.02, 0.05);
        part_type_size(ty, 0.04, 0.1, 0.002, 0.005);
        part_type_alpha3(ty, 1, 1, 0);
        part_type_colour1(ty, JamCBlue.ICE);
        part_type_gravity(ty, 0.1, 180);
        part_type_blend(ty, true);
    }
    part_particles_create(_sys, x + 10, y, ty, 1);
}

#macro JAM_SKYLINE_TOP make_colour_rgb(221, 166, 172) // make_colour_rgb(105, 70, 77);
#macro JAM_SKYLINE_BOTTOM make_colour_rgb(133, 141, 177) // make_colour_rgb(221, 166, 172);

/// @desc Spawns a skyline particle at the current position.
/// @param {real} sys The ID of the particle system to use.
/// @param {real} x1 The left position of the region to spawn particles in.
/// @param {real} y1 The top position of the region to spawn particles in.
/// @param {real} x2 The right position of the region to spawn particles in.
/// @param {real} y2 The bottom position of the region to spawn particles in.
function katsaii_witchwanda_wanda_sealine_spawn_particles(_sys, _left, _top, _right, _bottom) {
    static init = true;
    static ty = __WORKSPACE_PART_TYPE_CREATE(); // hi space :)
    if (init) {
        init = false;
        part_type_sprite(ty, katsaii_witchwanda_spr_wave, false, false, true);
        part_type_life(ty, 60, 60 * 4);
        part_type_direction(ty, 180, 180, 0, 0);
        part_type_speed(ty, 0.1, 0.2, 0, 0.00);
        part_type_scale(ty, 1, 0.1);
        part_type_alpha3(ty, 0, 1, 0);
        //part_type_colour1(ty, JAM_SKYLINE_TOP);
        part_type_blend(ty, true);
    }
    part_particles_create(_sys, random_range(_left, _right), random_range(_top, _bottom), ty, 1);
}

/// @desc Spawns a skyline cloud at the current position.
/// @param {real} sys The ID of the particle system to use.
/// @param {real} x1 The left position of the region to spawn particles in.
/// @param {real} y1 The top position of the region to spawn particles in.
/// @param {real} x2 The right position of the region to spawn particles in.
/// @param {real} y2 The bottom position of the region to spawn particles in.
function katsaii_witchwanda_wanda_skyline_spawn_particles(_sys, _left, _top, _right, _bottom) {
    static init = true;
    static ty = __WORKSPACE_PART_TYPE_CREATE(); // hi space :)
    if (init) {
        init = false;
        part_type_sprite(ty, katsaii_witchwanda_spr_cloud, false, false, true);
        part_type_life(ty, 60 * 6, 60 * 8);
        part_type_direction(ty, 180, 180, 0, 0);
        part_type_speed(ty, 0.2, 0.6, 0, 0.00);
        part_type_alpha3(ty, 0, 0.3, 0);
        part_type_blend(ty, true);
    }
    part_particles_create(_sys, random_range(_left, _right), random_range(_top, _bottom), ty, 1);
}

/// @desc Spawns a skyline island.
/// @param {real} sys The ID of the particle system to use.
/// @param {real} x1 The left position of the region to spawn particles in.
/// @param {real} y1 The top position of the region to spawn particles in.
/// @param {real} x2 The right position of the region to spawn particles in.
/// @param {real} y2 The bottom position of the region to spawn particles in.
function katsaii_witchwanda_wanda_island_spawn_particles(_sys, _left, _top, _right, _bottom) {
    static init = true;
    static ty = __WORKSPACE_PART_TYPE_CREATE(); // hi space :)
    if (init) {
        init = false;
        var life = 60 * 20;
        part_type_sprite(ty, katsaii_witchwanda_spr_island_floating, false, false, true);
        part_type_life(ty, life, life);
        part_type_direction(ty, 180, 180, 0, 0);
        part_type_speed(ty, 0.4, 0.9, 0, 0.00);
    }
    part_particles_create(_sys, random_range(_left, _right), random_range(_top, _bottom), ty, 1);
}

/// @desc Draws text in a 3d stylised way.
/// @param {real} x The x position to draw the text at.
/// @param {real} y The y position to draw the text at.
/// @param {real} text The text to draw.
/// @param {real} amount The amount of 3d layers to apply.
/// @param {real} outline The outline colour of the text.
/// @param {real} fill The fill of the text.
function katsaii_witchwanda_draw_text_3d(_x, _y, _text, _layer_count, _outline, _fill) {
    static sep = 1;
    var angle = current_time * 0.03 - _y * 3;
    var n = lerp(_layer_count / 2, _layer_count, min(dsin(angle * 4 + _y * 5) + 1, 1));
    var dx = lengthdir_x(sep, angle);
    var dy = lengthdir_y(sep, angle);
    for (var i = 0; i < n; i += 1) {
        var col = merge_color(_outline, _fill, i / _layer_count);
        draw_set_colour(col);
        katsaii_witchwanda_draw_text_wonky(_x + i * dx, _y + i * dy, _text);
    }
}

/// @desc Draws text in a stylised way.
/// @param {real} x The x position to draw the text at.
/// @param {real} y The y position to draw the text at.
/// @param {real} text The text to draw.
function katsaii_witchwanda_draw_text_wonky(_x, _y, _text) {
    var angle = 2 * dsin(-_y * 3 + current_time * 0.05);
    draw_text_transformed(_x, _y, _text, 1, 1, angle);
}

/// @desc Applies ease-in interpolation.
/// @param {real} amount The amount to interpolate.
function katsaii_witchwanda_easein(_interp) {
    static chan = animcurve_get_channel(katsaii_witchwanda_ac_ease, 0);
    return animcurve_channel_evaluate(chan, _interp);
}

/// @desc Applies mid-slow interpolation.
/// @param {real} amount The amount to interpolate.
function katsaii_witchwanda_midslow(_interp) {
    static chan = animcurve_get_channel(katsaii_witchwanda_ac_ease, 1);
    return animcurve_channel_evaluate(chan, _interp);
}

/// @desc Finds the coordinate at a bezier curve with 3 control points.
/// @param {real} amount The percentage along the bezier curve.
/// @param {real} x1 The X coordinate of the first control point.
/// @param {real} y1 The Y coordinate of the first control point.
/// @param {real} x2 The X coordinate of the second control point.
/// @param {real} y2 The Y coordinate of the second control point.
/// @param {real} x3 The X coordinate of the third control point.
/// @param {real} y3 The Y coordinate of the third control point.
/// @author Kat @katsaii
function katsaii_witchwanda_lerp_bezier(_amount, _x1, _y1, _x2, _y2, _x3, _y3) {
    var ix = lerp(_x1, _x2, _amount);
    var iy = lerp(_y1, _y2, _amount);
    var jx = lerp(_x2, _x3, _amount);
    var jy = lerp(_y2, _y3, _amount);
    // get final curve point
    var bx = lerp(ix, jx, _amount);
    var by = lerp(iy, jy, _amount);
    return [bx, by];
}

/// @desc Spawns an enemy at this position with this x and y amplitude.
/// @param {real} x The X coordinate of the enemy.
/// @param {real} y The Y coordinate of the enemy.
/// @param {real} rx The X radius of the enemy.
/// @param {real} ry The Y radius of the enemy.
function katsaii_witchwanda_spawn_enemy(_x, _y, _amp_x, _amp_y) {
    var inst = instance_create_layer(_x, _y, layer, katsaii_witchwanda_obj_enemy);
    with (inst) {
        amplitudeX = _amp_x;
        amplitudeY = _amp_y;
    }
    return inst;
}

#macro JAM_COLOUR_BLEND merge_colour(JamCPurple.MARDI_GRAS, JamCYellow.REKINDLED, (1 + dsin(current_time * 0.1)) / 8)

/// @desc Represents various red shades.
enum JamCRed {
	FORREST_FIRE = 0x3e3ed2,
	BREAD = 0x758ab6
}

/// @desc Represents various yellow shades.
enum JamCYellow {
	REKINDLED = 0xb2f4ff,
	GOLDEN_SHOWER = 0x28dfff
}

/// @desc Represents various blue shades.
enum JamCBlue {
	BIG_BLUE = 0xcc6600,
	DEEP_SKY = 0xffbf00,
	INCOGNITO_GREEN = 0x5f5636,
	ICE = 0xf4cc74
}

/// @desc Represents various purple shades.
enum JamCPurple {
	PALIA = 0x110010,
	MARDI_GRAS = 0x352235
}

/// @desc Represents various pink shades.
enum JamCPink {
	WILD_STRAWBERRY = 0x963eff,
	RUBY = 0x6600cc,
	DAMAGE = 0xff7df9,
	LILY = 0xaa8cbc
}

/// @desc Represents various green shades.
enum JamCGreen {
	MORNING_DEW = 0x556b2f,
	WARFARE = 0x58764c,
	GRASS = 0x53833f,
	GOBLIN = 0x3D5334
}