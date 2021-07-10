var left = 0;
var top = 0;
var right = room_width;
var bottom = room_height;
var midx = mean(left, right);
var midy = mean(top, bottom);
var amounts = [0, 0.5, 1];
var offsets = [0, -0.5, -1];
var table_height = 70;
draw_rectangle_colour(left, bottom - table_height, right, bottom, c_gbbacklight, c_gbbacklight, c_gbbacklight, c_gbbacklight, false);
for (var i = 0; i <= 2; i += 1) {
    var amount = lerp(0.15, 0.85, amounts[i]);
    var pos_x = lerp(left, right, amount);
    var pos_y = bottom - table_height / 2;
    var wiggle = sin(current_time * 0.01 + pos_x);
    var scale = lerp(0.95, 1.05, (wiggle + 1) / 2);
    var img = wandOrder[i];
    draw_sprite_ext(wandSprite, img, pos_x, pos_y, scale, scale, 2 * wiggle, c_white, 1);
}
draw_circle(lerp(left, right, selectionAmount), bottom - 10, 10, false);