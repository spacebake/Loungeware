var left = 0;
var top = 0;
var right = room_width;
var bottom = room_height;
var midx = mean(left, right);
var midy = mean(top, bottom);
var amounts = [0, 0.5, 1];
var offsets = [0, -0.5, -1];
var table_height = 150;
//draw_rectangle_colour(left, bottom - table_height, right, bottom, c_gbbacklight, c_gbbacklight, c_gbbacklight, c_gbbacklight, false);
for (var i = 0; i <= 2; i += 1) {
    var amount = lerp(0.15, 0.85, amounts[i]);
    var pos_x = lerp(left, right, amount);
    var pos_y = bottom - table_height * 1.1;
    var pos_y_pentagram = bottom - table_height * 0.5;
    var wiggle = sin(current_time * 0.01 + pos_x);
    var scale = lerp(0.95, 1.05, (wiggle + 1) / 2);
    var scale2 = scale;
    if (i == selectionID) {
        scale2 *= 1.5;
    }
    var img = wandOrder[i];
    if (wandCurrent == img) {
        var fade = craftAnimation == -1 ? 1 : abs(lerp(-1, 0, craftAnimation));
        matrix_set(matrix_world, matrix_build(pos_x, pos_y_pentagram, 0, 0, 0, 0, 1, 0.5, 1));
        draw_sprite_ext(katsaii_witchcraft_pentagram, 0, 0, 0, 0.5 * scale + 0.05 * wiggle, 0.5 * scale, -current_time * 0.1, c_white, fade * 0.75);
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(katsaii_witchcraft_pentagram, 0, 0, 0, 0.5 * scale, 0.5 * scale + 0.05 * wiggle, current_time * 0.1, c_white, fade * 0.5);
        gpu_set_blendmode(bm_normal);
        matrix_set(matrix_world, matrix_build_identity());
    }
    if (img >= wandCurrent) {
        draw_sprite_ext(wandSprite, img, pos_x, pos_y, scale2, scale2, 2 * wiggle, c_white, 1);
        if (i == selectionID) {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(wandSprite, img, pos_x, pos_y, scale2, scale2, 2 * wiggle, c_white, 1);
            gpu_set_blendmode(bm_normal);
        }
    }
}
var angle = lerp(0, 180, selectionAmount);
var weight = dsin(angle);
var smooth = (1 - dsin(angle + 90)) / 2;
var yoffset = 0;
if (craftAnimation != -1) {
    if (craftAnimation < 1) {
        yoffset = craftAnimation * 300;
    } else {
        yoffset = (2 - craftAnimation) * 300;
    }
}
draw_sprite_ext(katsaii_witchcraft_cat, 0, lerp(left, right, smooth), bottom + 100 + yoffset, 1.5, 1.5, weight * 20 * sign(selectionSpeed), c_white, 1);
if (failed || win) {
    var fg = failed ? katsaii_witchcraft_finish_bad : katsaii_witchcraft_finish_good;
    var bg = failed ? katsaii_witchcraft_finish_bad_bg : katsaii_witchcraft_finish_good_bg;
    var msg = failed ? katsaii_witchcraft_finish_bad_msg : katsaii_witchcraft_finish_good_msg;
    var scale_multiplier = failed ? 1.5 : 1.2;
    var scale_limit = failed ? 1.4 : 1.1;
    var wiggle1 = sin(current_time * 0.01);
    var wiggle2 = sin(current_time * 0.01 + 0.5 * pi);
    draw_sprite_ext(bg, 0, midx, midy, scale_multiplier * lerp(1, scale_limit, (wiggle2 + 1) / 2), scale_multiplier, 5 * wiggle1, c_white, resultTimer);
    draw_sprite_ext(fg, 0, midx + lerp(-600, 0, resultTimer * resultTimer), midy, 1.1, 1.1 + 0.05 * wiggle2, 2 * -wiggle1, c_white, resultTimer);
    draw_sprite_ext(msg, 0, midx, mean(midy, bottom) + lerp(200, 0, resultTimer * resultTimer), 1 + 0.05 * wiggle2, 1 + 0.05 * wiggle1, 2 * -wiggle2, c_white, resultTimer);
}