
#macro KATSAII_WANDARING_FOLIAGE_RED make_colour_rgb(251, 192, 192)
#macro KATSAII_WANDARING_FOLIAGE_ORANGE make_colour_rgb(255, 218, 161)
#macro KATSAII_WANDARING_FOLIAGE_ORANGE_2 make_colour_rgb(244, 154, 63)
#macro KATSAII_WANDARING_FOLIAGE_YELLOW make_colour_rgb(249, 255, 201)
#macro KATSAII_WANDARING_FOLIAGE_GREEN make_colour_rgb(186, 255, 229)
#macro KATSAII_WANDARING_FOLIAGE_GREEN_2 make_colour_rgb(106, 165, 118)
#macro KATSAII_WANDARING_FOLIAGE_BLUE make_colour_rgb(169, 205, 255)
#macro KATSAII_WANDARING_FOLIAGE_PURPLE make_colour_rgb(124, 84, 101)
#macro KATSAII_WANDARING_FOLIAGE_GREY make_colour_rgb(221, 221, 221)
#macro KATSAII_WANDARING_FOLIAGE_PINK make_colour_rgb(255, 70, 131)

/// @desc Draws a simple dithering effect, but keeps the same colour blend.
function katsaii_wandaring_shader_set_effect_dissolve() {
    if (shader_is_compiled(katsaii_wandaring_shd_dissolve)) {
        shader_set(katsaii_wandaring_shd_dissolve);
    }
}

/// @desc Only colours greyscale pixels.
function katsaii_wandaring_shader_set_effect_colour_grey() {
    if (shader_is_compiled(katsaii_wandaring_shd_colour_grey)) {
        shader_set(katsaii_wandaring_shd_colour_grey);
    }
}

function katsaii_wandaring_get_foliage_colour(_z) {
    var n = floor(_z / KATSAII_WANDARING_CELL_SIZE);
    n = ((n % 10) + 10) % 10;
    return katsaii_wandaring_obj_control.colours[n];
}

#macro KATSAII_WANDARING_CELL_SIZE (16)
#macro KATSAII_WANDARING_CELL_LEFT (1)
#macro KATSAII_WANDARING_CELL_BOTTOM (2)
#macro KATSAII_WANDARING_CELL_RIGHT (4)
#macro KATSAII_WANDARING_CELL_TOP (8)
#macro KATSAII_WANDARING_CELL_ALL (KATSAII_WANDARING_CELL_LEFT | KATSAII_WANDARING_CELL_BOTTOM | KATSAII_WANDARING_CELL_RIGHT | KATSAII_WANDARING_CELL_TOP)
#macro KATSAII_WANDARING_CELL_NONE (0)

function katsaii_wandaring_draw_island(_cell_x, _cell_y, _height, _occlude) {
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
    katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 0);
    katsaii_wandaring_rf3d_add_sprite_pos(
            x1, y1, z_top,
            x2, y1, z_top,
            x2, y2, z_top,
            x1, y2, z_top, col);
    katsaii_wandaring_rf3d_draw_end();
    katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 1);
    if not (_occlude & KATSAII_WANDARING_CELL_LEFT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y1, z_top,
                x1, y2, z_top,
                x1, y2, z_bot,
                x1, y1, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_BOTTOM) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y2, z_top,
                x2, y2, z_top,
                x2, y2, z_bot,
                x1, y2, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_RIGHT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y2, z_top,
                x2, y1, z_top,
                x2, y1, z_bot,
                x2, y2, z_bot, col_cliff);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_TOP) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y1, z_top,
                x1, y1, z_top,
                x1, y1, z_bot,
                x2, y1, z_bot, col_cliff);
    }
    katsaii_wandaring_rf3d_draw_end();
    katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass_edge, 0);
    var hang = 3;
    if not (_occlude & KATSAII_WANDARING_CELL_LEFT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y1, z_top,
                x1, y2, z_top,
                x1 - hang, y2, z_top + hang,
                x1 - hang, y1, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_BOTTOM) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x1, y2, z_top,
                x2, y2, z_top,
                x2, y2 + hang, z_top + hang,
                x1, y2 + hang, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_RIGHT) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y2, z_top,
                x2, y1, z_top,
                x2 + hang, y1, z_top + hang,
                x2 + hang, y2, z_top + hang, col);
    }
    if not (_occlude & KATSAII_WANDARING_CELL_TOP) {
        katsaii_wandaring_rf3d_add_sprite_pos(
                x2, y1, z_top,
                x1, y1, z_top,
                x1, y1 - hang, z_top + hang,
                x2, y1 - hang, z_top + hang, col);
    }
    katsaii_wandaring_rf3d_draw_end();
}

function katsaii_wandaring_instance_create_on_grid(_row, _col, _obj, _offset=undefined) {
    _row *= katsaii_wandaring_obj_control.mirrorX;
    _col *= katsaii_wandaring_obj_control.mirrorY;
    if (_obj != katsaii_wandaring_obj_platform) {
        _row += 0.5;
        _col += 0.5;
    }
    var inst = instance_create_layer(_row * KATSAII_WANDARING_CELL_SIZE, _col * KATSAII_WANDARING_CELL_SIZE, layer, _obj);
    if (_offset != undefined) {
        inst.z = -(_offset + 1) * KATSAII_WANDARING_CELL_SIZE;
        inst.zstart = inst.z;
        if (_obj == katsaii_wandaring_obj_foliage || _obj == katsaii_wandaring_obj_platform) {
            inst.image_blend = katsaii_wandaring_get_foliage_colour(inst.z);
        }
    }
    return inst;
}

function katsaii_wandaring_instance_create_on_grid_region(_row_1, _col_1, _row_2, _col_2, _obj, _offset=undefined, _step=1) {
    var step = abs(_step);
    var row_start = min(_row_1, _row_2);
    var row_end = max(_row_1, _row_2);
    var col_start = min(_col_1, _col_2);
    var col_end = max(_col_1, _col_2);
    for (var i = row_start; i <= row_end; i += step) {
        for (var j = col_start; j <= col_end; j += step) {
            katsaii_wandaring_instance_create_on_grid(i, j, _obj, _offset);
        }
    }
}

function katsaii_wandaring_instance_create_particle(_x, _y, _z, _speed, _angle, _pitch) {
    var inst = instance_create_layer(_x, _y, layer, katsaii_wandaring_obj_particle);
    with (inst) {
        z = _z;
        xspeed = _speed * dcos(_angle);
        var v_x_pitch_radius = dsin(_angle);
        yspeed = _speed * v_x_pitch_radius * -dcos(_pitch);
        zspeed = _speed * v_x_pitch_radius * dsin(_pitch);
    }
    return inst;
}

function katsaii_wandaring_generate_random_room() {
    var class_a = choose(6);
    var class_b = choose(0, 2, 3, 7);
    var class_c = choose(1, 4, 5, 8);
    var levels = [class_a, choose(class_a, class_b), class_b, choose(class_b, class_c), class_c];
    var level = levels[DIFFICULTY - 1];
    switch (level) {
    case 0:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 1);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_star, 3.5);
        break;
    case 1:
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_platform, 9);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 9);
        katsaii_wandaring_instance_create_on_grid(2.25, 0, katsaii_wandaring_obj_star, 11.5);
        katsaii_wandaring_instance_create_on_grid(-2.25, 0, katsaii_wandaring_obj_star, 11.5);
        katsaii_wandaring_instance_create_on_grid(0, 2.25, katsaii_wandaring_obj_star, 11.5);
        katsaii_wandaring_instance_create_on_grid(0, -2.25, katsaii_wandaring_obj_star, 11.5);
        break;
    case 2:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_star, 4);
        katsaii_wandaring_instance_create_on_grid(2, 0, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(3, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(4, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(5, 0, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(6, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(7, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(8, 0, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid_region(9, -1, 9, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(10, -1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(10, 0, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(10, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid_region(11, -1, 11, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(12, 0, katsaii_wandaring_obj_star, 3);
        break;
    case 3:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 1);
        katsaii_wandaring_instance_create_on_grid_region(-5, -5, -3, -3, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid_region(5, 5, 3, 3, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid_region(-5, 5, -3, 3, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid_region(5, -5, 3, -3, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(-4, 0, katsaii_wandaring_obj_platform, 3);
        katsaii_wandaring_instance_create_on_grid(4, 0, katsaii_wandaring_obj_platform, 3);
        katsaii_wandaring_instance_create_on_grid(0, -4, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(0, 4, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(0, 4, katsaii_wandaring_obj_star, 4);
        katsaii_wandaring_instance_create_on_grid(4, 4, katsaii_wandaring_obj_star, 2);
        katsaii_wandaring_instance_create_on_grid(-4, -4, katsaii_wandaring_obj_star, 1);
        break;
    case 4:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_star, 7);
        katsaii_wandaring_instance_create_on_grid(2, 0, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(3, 0, katsaii_wandaring_obj_platform, 3);
        katsaii_wandaring_instance_create_on_grid(4, 1, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(4, 0, katsaii_wandaring_obj_platform, 5);
        katsaii_wandaring_instance_create_on_grid(5, -1, katsaii_wandaring_obj_platform, 4);
        katsaii_wandaring_instance_create_on_grid(4, -2, katsaii_wandaring_obj_platform, 6);
        katsaii_wandaring_instance_create_on_grid(5, -3, katsaii_wandaring_obj_platform, 8);
        katsaii_wandaring_instance_create_on_grid(6, -4, katsaii_wandaring_obj_platform, 6);
        katsaii_wandaring_instance_create_on_grid(8, -4, katsaii_wandaring_obj_platform, 7);
        katsaii_wandaring_instance_create_on_grid(2, -3, katsaii_wandaring_obj_platform, 9);
        break;
    case 5:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 0);
        katsaii_wandaring_instance_create_on_grid(-4, 0, katsaii_wandaring_obj_star, 0);
        katsaii_wandaring_instance_create_on_grid(2, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(3, 0, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(4, 0, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(5, 1, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(6, 2, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(7, 2, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(8, 2, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid_region(9, 1, 11, 3, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(10, 2, katsaii_wandaring_obj_star, 1);
        break;
    case 6:
        katsaii_wandaring_instance_create_on_grid_region(-1, -4, 1, 4, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid_region(2, -4, 2, 4, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 0);
        katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_star, 4);
        katsaii_wandaring_instance_create_on_grid(0, -3, katsaii_wandaring_obj_star, 4);
        katsaii_wandaring_instance_create_on_grid(0, 3, katsaii_wandaring_obj_star, 4);
        break;
    case 7:
        katsaii_wandaring_instance_create_on_grid_region(-1, -1, 1, 1, katsaii_wandaring_obj_platform, 9);
        katsaii_wandaring_instance_create_on_grid(3, 0, katsaii_wandaring_obj_platform, 8);
        katsaii_wandaring_instance_create_on_grid(5, 0, katsaii_wandaring_obj_platform, 7);
        katsaii_wandaring_instance_create_on_grid(7, 0, katsaii_wandaring_obj_platform, 6);
        katsaii_wandaring_instance_create_on_grid(7, 0, katsaii_wandaring_obj_wanda, 6);
        katsaii_wandaring_instance_create_on_grid(0, 4.5, katsaii_wandaring_obj_star, 8);
        katsaii_wandaring_instance_create_on_grid(0, 3.5, katsaii_wandaring_obj_star, 6);
        katsaii_wandaring_instance_create_on_grid(0, 3, katsaii_wandaring_obj_star, 4);
        katsaii_wandaring_instance_create_on_grid(0, 2.5, katsaii_wandaring_obj_star, 2);
        katsaii_wandaring_instance_create_on_grid(0, 2, katsaii_wandaring_obj_star, 0);
        break;
    case 8:
        katsaii_wandaring_instance_create_on_grid_region(0, -1, 2, 1, katsaii_wandaring_obj_platform, 0);
        katsaii_wandaring_instance_create_on_grid(1, 0, katsaii_wandaring_obj_wanda, 0);
        katsaii_wandaring_instance_create_on_grid(3, 0, katsaii_wandaring_obj_platform, 1);
        katsaii_wandaring_instance_create_on_grid(3, 1, katsaii_wandaring_obj_platform, 3);
        katsaii_wandaring_instance_create_on_grid(3, 2, katsaii_wandaring_obj_platform, 5);
        katsaii_wandaring_instance_create_on_grid(3, 3, katsaii_wandaring_obj_platform, 7);
        katsaii_wandaring_instance_create_on_grid(3, 4, katsaii_wandaring_obj_platform, 9);
        katsaii_wandaring_instance_create_on_grid(1, 2, katsaii_wandaring_obj_platform, 2);
        katsaii_wandaring_instance_create_on_grid(1, 3, katsaii_wandaring_obj_platform, 4);
        katsaii_wandaring_instance_create_on_grid(1, 4, katsaii_wandaring_obj_platform, 6);
        katsaii_wandaring_instance_create_on_grid(1, 5, katsaii_wandaring_obj_platform, 8);
        katsaii_wandaring_instance_create_on_grid(3, 4, katsaii_wandaring_obj_star, 10);
        break;
    }
}