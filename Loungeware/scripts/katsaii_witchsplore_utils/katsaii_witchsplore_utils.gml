
function katsaii_witchsplore_generate_island(_x, _y, _w, _h) {
    with (instance_create_layer(_x, _y, layer, katsaii_witchsplore_island)) {
        width = _w;
        height = _h;
    }
}

function katsaii_witchsplore_generate_goal(_x, _y) {
    instance_create_layer(_x, _y, layer, katsaii_witchsplore_exit);
}

function katsaii_witchsplore_generate_random_level() {
    switch (irandom(0)) {
    case 0:
        var widths = [20, 13, 10, 7, 5];
        var lengths = [100, 200, 300, 350, 400];
        var width = widths[DIFFICULTY - 1];
        var length = lengths[DIFFICULTY - 1];
        katsaii_witchsplore_generate_island(0, 0, 100, 100);
        katsaii_witchsplore_generate_island(50 + length / 2, 0, length, width);
        katsaii_witchsplore_generate_island(100 + length, 0, 100, 100);
        katsaii_witchsplore_generate_goal(100 + length, 0);
        break;
    }
}

function katsaii_witchsplore_transform_point(_x, _y) {
    static arr = [0, 0];
    var off_x = _x - katsaii_witchsplore_player.offX;
    var off_y = _y - katsaii_witchsplore_player.offY;
    var axis_x = katsaii_witchsplore_player.vX;
    var axis_y = katsaii_witchsplore_player.vY;
    arr[@ 0] = off_x * axis_x[0] + off_y * axis_y[0];
    arr[@ 1] = off_x * axis_x[1] + off_y * axis_y[1];
    return arr;
}

function katsaii_witchsplore_draw_island(_x, _y, _z, _w, _h, _depth=200) {
    var v;
    v = katsaii_witchsplore_transform_point(_x, _y);
    var x1 = v[0];
    var y1 = v[1];
    v = katsaii_witchsplore_transform_point(_x + _w, _y);
    var x2 = v[0];
    var y2 = v[1];
    v = katsaii_witchsplore_transform_point(_x + _w, _y + _h);
    var x3 = v[0];
    var y3 = v[1];
    v = katsaii_witchsplore_transform_point(_x, _y + _h);
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