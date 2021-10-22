
function katsaii_wandaxplore_generate_island(_x, _y, _w, _h) {
    with (instance_create_layer(_x, _y, layer, katsaii_wandaxplore_island)) {
        width = _w;
        height = _h;
    }
}

function katsaii_wandaxplore_generate_goal(_x, _y) {
    instance_create_layer(_x, _y, layer, katsaii_wandaxplore_exit);
}

function katsaii_wandaxplore_generate_random_level() {
    switch (irandom(1)) {
    case 0:
        var width = 5;
        var length = 75;
        var rad = 50;
        var pivot_x = 0;
        var pivot_y = 0;
        var grid_x = 0;
        var grid_y = 0;
        var grid = ds_map_create();
        katsaii_wandaxplore_generate_island(pivot_x, pivot_y, rad, rad);
        grid[? string([round(grid_x), round(grid_y)])] = true;
        var angle_last = 0;
        for (var i = DIFFICULTY - 1; i >= 0; i -= 1) {
            var jump_grid_x, jump_grid_y;
            var angle;
            do {
                angle = irandom(3);
            } until (angle != angle_last);
            switch (angle) {
            case 0:
                jump_grid_x = 0;
                jump_grid_y = 1;
                break;
            case 1:
                jump_grid_x = 0;
                jump_grid_y = -1;
                break;
            case 2:
                jump_grid_x = 1;
                jump_grid_y = 0;
                break;
            case 3:
                jump_grid_x = -1;
                jump_grid_y = 0;
                break;
            }
            if (ds_map_exists(grid, string([round(grid_x + jump_grid_x), round(grid_y + jump_grid_y)]))) {
                i += 1;
                continue;
            }
            log([angle, angle_last]);
            angle_last = angle;
            var jump_x = (rad + length) / 2 * jump_grid_x;
            var jump_y = (rad + length) / 2 * jump_grid_y;
            grid_x += jump_grid_x;
            grid_y += jump_grid_y;
            pivot_x += jump_x;
            pivot_y += jump_y;
            var random_scale = choose(1, 1, 1, 1, 0.5);
            katsaii_wandaxplore_generate_island(pivot_x, pivot_y,
                    jump_grid_x != 0 ? random_scale * length : width,
                    jump_grid_x != 0 ? width : random_scale * length);
            pivot_x += jump_x;
            pivot_y += jump_y;
            katsaii_wandaxplore_generate_island(pivot_x, pivot_y, rad, rad);
            grid[? string([round(grid_x), round(grid_y)])] = true;
            if (i == 0) {
                katsaii_wandaxplore_generate_goal(pivot_x, pivot_y);
            }
        }
        ds_map_destroy(grid);
        break;
    case 1:
        var seps = [13, 17, 20, 23, 28];
        var rads = [[50, 75], [40, 75], [30, 55], [15, 35], [5, 15]];
        var counts = [3, 4, 5, 5, 6];
        var sep = seps[DIFFICULTY - 1];
        var rad_minmax = rads[DIFFICULTY - 1];
        var count = counts[DIFFICULTY - 1];
        var pivot_x = 0;
        var pivot_y = 0;
        var rad = 100;
        var angle = 0;
        katsaii_wandaxplore_generate_island(pivot_x, pivot_y, rad, rad);
        for (var i = count; i >= 0; i -= 1) {
            angle += random_range(-45, 45);
            var jump_x = lengthdir_x(1, angle);
            var jump_y = lengthdir_y(1, angle);
            var next_rad = i == 0 ? 100 : random_range(rad_minmax[0], rad_minmax[1]);
            var jump_target = rad / 2 + next_rad / 2 + sep;
            var jump_x_scale = jump_target / abs(jump_x);
            var jump_y_scale = jump_target / abs(jump_y);
            var jump_scale = min(jump_x_scale, jump_y_scale);
            pivot_x += jump_x * jump_scale;
            pivot_y += jump_y * jump_scale;
            rad = next_rad;
            katsaii_wandaxplore_generate_island(pivot_x, pivot_y, rad, rad);
            if (i == 0) {
                katsaii_wandaxplore_generate_goal(pivot_x, pivot_y);
            }
        }
        break;
    }
}

function katsaii_wandaxplore_transform_point(_x, _y) {
    static arr = [0, 0];
    var off_x = _x - katsaii_wandaxplore_player.offX;
    var off_y = _y - katsaii_wandaxplore_player.offY;
    var axis_x = katsaii_wandaxplore_player.vX;
    var axis_y = katsaii_wandaxplore_player.vY;
    arr[@ 0] = off_x * axis_x[0] + off_y * axis_y[0];
    arr[@ 1] = off_x * axis_x[1] + off_y * axis_y[1];
    return arr;
}

function katsaii_wandaxplore_draw_island(_x, _y, _z, _w, _h, _depth=200) {
    var v;
    v = katsaii_wandaxplore_transform_point(_x, _y);
    var x1 = v[0];
    var y1 = v[1];
    v = katsaii_wandaxplore_transform_point(_x + _w, _y);
    var x2 = v[0];
    var y2 = v[1];
    v = katsaii_wandaxplore_transform_point(_x + _w, _y + _h);
    var x3 = v[0];
    var y3 = v[1];
    v = katsaii_wandaxplore_transform_point(_x, _y + _h);
    var x4 = v[0];
    var y4 = v[1];
    var step = 0.0125;
    var dark = -1;
    draw_primitive_begin(pr_trianglelist);
    for (var i = 0; i <= 1; i += step) {
        dark += 1;
        if (dark >= 4) {
            dark = 0;
        }
        var col = merge_color(KATSAII_WITCHSPLORE_SKY_PINK,
                dark < 2 ? KATSAII_WITCHSPLORE_CLIFF_DARK : KATSAII_WITCHSPLORE_CLIFF_LIGHT, i);
        if (1 - i < step) {
            col = KATSAII_WITCHSPLORE_CLIFF_GRASS;
        } else if (1 - i < 2 * step) {
            col = merge_colour(col, KATSAII_WITCHSPLORE_CLIFF_GRASS, 0.5);
        }
        var off_y = lerp(_z + _depth, _z, i);
        draw_vertex_color(x1, y1 + off_y, col, 1);
        draw_vertex_color(x2, y2 + off_y, col, 1);
        draw_vertex_color(x4, y4 + off_y, col, 1);
        draw_vertex_color(x4, y4 + off_y, col, 1);
        draw_vertex_color(x2, y2 + off_y, col, 1);
        draw_vertex_color(x3, y3 + off_y, col, 1);
    }
    draw_primitive_end();
}

#macro KATSAII_WITCHSPLORE_SKY_BLUE make_color_rgb(138, 200, 245)
#macro KATSAII_WITCHSPLORE_SKY_PINK make_color_rgb(231, 181, 202)
#macro KATSAII_WITCHSPLORE_CLIFF_DARK make_colour_rgb(110, 101, 98)
#macro KATSAII_WITCHSPLORE_CLIFF_LIGHT make_colour_rgb(138, 123, 118)
#macro KATSAII_WITCHSPLORE_CLIFF_GRASS make_colour_rgb(119, 158, 181)
#macro KATSAII_WITCHSPLORE_CLIFF_FAR make_colour_rgb(205, 147, 154)

//make_colour_rgb(145, 105, 92); //make_colour_rgb(140, 98, 74);
//make_colour_rgb(193, 168, 135);