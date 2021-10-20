/// @desc Draw the platforms. (TEMPORARY)
katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 0);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
    katsaii_wandaring_rf3d_add_sprite_pos(
            x1, y1, z_top,
            x2, y1, z_top,
            x2, y2, z_top,
            x1, y2, z_top, col);
}
katsaii_wandaring_rf3d_draw_end();
katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass, 1);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
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
}
katsaii_wandaring_rf3d_draw_end();
katsaii_wandaring_rf3d_draw_begin(katsaii_wandaring_spr_grass_edge, 0);
with (katsaii_wandaring_obj_platform) {
    var _cell_x = x;
    var _cell_y = y;
    var _height = z;
    var _occlude = cullFlags;
    var col = image_blend;
    var col_cliff = make_colour_rgb(171, 134, 113);
    var x1 = _cell_x;
    var y1 = _cell_y;
    var x2 = x1 + KATSAII_WANDARING_CELL_SIZE;
    var y2 = y1 + KATSAII_WANDARING_CELL_SIZE;
    var z_bot = 0;
    var z_top = _height;
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
}
katsaii_wandaring_rf3d_draw_end();