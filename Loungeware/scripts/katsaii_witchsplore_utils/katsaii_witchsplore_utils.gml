
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
    draw_primitive_begin(pr_trianglestrip);
    for (var i = 0; i <= 1; i += step) {
        dark += 1;
        if (dark >= 4) {
            dark = 0;
        }
        var col = merge_color(KATSAII_WITCHSPLORE_SKY_PINK,
                dark < 2 ? KATSAII_WITCHSPLORE_CLIFF_DARK : KATSAII_WITCHSPLORE_CLIFF_LIGHT, i);
        if (1 - i < step) {
            col = KATSAII_WITCHSPLORE_CLIFF_GRASS;
        }
        var off_y = lerp(_z + _depth, _z, i);
        draw_vertex_color(x1, y1 + off_y, col, 1);
        draw_vertex_color(x2, y2 + off_y, col, 1);
        draw_vertex_color(x4, y4 + off_y, col, 1);
        draw_vertex_color(x3, y3 + off_y, col, 1);
    }
    draw_primitive_end();
}

#macro KATSAII_WITCHSPLORE_SKY_BLUE make_color_rgb(138, 200, 245)
#macro KATSAII_WITCHSPLORE_SKY_PINK make_color_rgb(231, 181, 202)
#macro KATSAII_WITCHSPLORE_CLIFF_DARK make_colour_rgb(110, 101, 98)
#macro KATSAII_WITCHSPLORE_CLIFF_LIGHT make_colour_rgb(138, 123, 118)
#macro KATSAII_WITCHSPLORE_CLIFF_GRASS make_colour_rgb(119, 158, 181)

//make_colour_rgb(145, 105, 92); //make_colour_rgb(140, 98, 74);
//make_colour_rgb(193, 168, 135);