
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
    static colours = [
        KATSAII_WANDARING_FOLIAGE_BLUE,
        KATSAII_WANDARING_FOLIAGE_GREEN,
        KATSAII_WANDARING_FOLIAGE_GREY,
        KATSAII_WANDARING_FOLIAGE_GREEN_2,
        KATSAII_WANDARING_FOLIAGE_YELLOW,
        KATSAII_WANDARING_FOLIAGE_PINK,
        KATSAII_WANDARING_FOLIAGE_PURPLE,
        KATSAII_WANDARING_FOLIAGE_ORANGE,
        KATSAII_WANDARING_FOLIAGE_RED,
        KATSAII_WANDARING_FOLIAGE_ORANGE_2,
    ];
    var n = floor(_z / KATSAII_WANDARING_CELL_SIZE);
    n = ((n % 10) + 10) % 10;
    return colours[n];
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

function katsaii_wandaring_convert_byte_to_number(_byte) {
    if (_byte >= ord("0") && _byte <= ord("9")) {
        return _byte - ord("0");
    }
    return 0;
}

function katsaii_wandaring_load_room_from_file(_path) {
    var grid = load_csv(_path);
    for (var row = ds_grid_width(grid) - 1; row >= 0; row -= 1) {
        for (var col = ds_grid_height(grid) - 1; col >= 0; col -= 1) {
            var line = grid[# row, col];
            if not (is_string(line)) {
                line = string(line);
            }
            switch (string_length(line)) {
            case 0:
                line += "X";
            case 1:
                line += "0";
            case 2:
                line += "X";
            case 3:
                line += "0";
            }
            var p_type = string_byte_at(line, 1);
            var p_offset = katsaii_wandaring_convert_byte_to_number(string_byte_at(line, 2));
            var e_type = string_byte_at(line, 3);
            var e_offset = katsaii_wandaring_convert_byte_to_number(string_byte_at(line, 4)) + p_offset;
            switch (p_type) {
            case ord("X"):
                break;
            case ord("p"):
                katsaii_wandaring_instance_create_on_grid(row, col, katsaii_wandaring_obj_platform, p_offset);
                break;
            }
            var e_row = row + 0.5;
            var e_col = col + 0.5;
            switch (e_type) {
            case ord("X"):
                break;
            case ord("w"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_wanda, e_offset);
                break;
            case ord("s"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_star, e_offset);
                break;
            case ord("T"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_foliage, e_offset).image_index = choose(2, 3);
                break;
            case ord("t"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_foliage, e_offset).image_index = 4;
                break;
            case ord("b"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_foliage, e_offset).image_index = choose(0, 1);
                break;
            case ord("c"):
                katsaii_wandaring_instance_create_on_grid(e_row, e_col, katsaii_wandaring_obj_candy, e_offset).image_index = choose(5, 6, 7, 8, 9);
                break;
            }
        }
    }
    ds_grid_destroy(grid);
}

function katsaii_wandaring_generate_random_room() {
    katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_platform, 0);
    katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_wanda, 0);
    katsaii_wandaring_instance_create_on_grid(0, 0, katsaii_wandaring_obj_star, 5);
    for (var i = 0; i < 10; i += 1) {
        for (var j = 0; j < 10; j += 1) {
            katsaii_wandaring_instance_create_on_grid(2 + i, j, katsaii_wandaring_obj_platform, 0);
        }
    }
    katsaii_wandaring_instance_create_on_grid(-2, 0, katsaii_wandaring_obj_platform, 1);
    katsaii_wandaring_instance_create_on_grid(-3, 0, katsaii_wandaring_obj_platform, 2);
    katsaii_wandaring_instance_create_on_grid(-4, 0, katsaii_wandaring_obj_platform, 4);
}