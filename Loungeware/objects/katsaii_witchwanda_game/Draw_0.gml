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
    var pos_y = bottom - table_height / 2;
    var wiggle = sin(current_time * 0.01 + pos_x);
    var scale = lerp(0.95, 1.05, (wiggle + 1) / 2);
    if (i == selectionID) {
        scale *= 2;
    }
    var img = wandOrder[i];
    if (img >= wandCurrent) {
        draw_sprite_ext(wandSprite, img, pos_x, pos_y, scale, scale, 2 * wiggle, c_white, 1);
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
draw_sprite_ext(katsaii_witchwanda_cat, 0, lerp(left, right, smooth), bottom + yoffset, 1, 1, weight * 20 * sign(selectionSpeed), c_white, 1);
if (failed || win) {
    var fg = failed ? katsaii_witchwanda_finish_bad : katsaii_witchwanda_finish_bad;
    var bg = failed ? katsaii_witchwanda_finish_bad_bg : katsaii_witchwanda_finish_bad_bg;
    var wiggle1 = sin(current_time * 0.01);
    var wiggle2 = sin(current_time * 0.01 + 0.5 * pi);
    draw_sprite_ext(bg, 0, midx, midy, lerp(1.4, 2, (wiggle2 + 1) / 2), 1.5, 5 * wiggle1, c_white, resultTimer);
    draw_sprite_ext(fg, 0, midx + lerp(-600, 0, resultTimer * resultTimer), midy, 1.1, 1.1 + 0.05 * wiggle2, 2 * -wiggle1, c_white, resultTimer);
}