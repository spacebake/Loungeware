var left = 0;
var top = 0;
var right = room_width;
var bottom = room_height;
var midx = mean(left, right);
var midy = mean(top, bottom);
var avatar_img = sin(current_time * 0.005) > 0;
draw_sprite(katsaii_witchwanda_avatar, avatar_img, midx + irandom_range(-1, 1), bottom);
var item_width = sprite_get_width(katsaii_witchwanda_ui);
var item_height = sprite_get_height(katsaii_witchwanda_ui);
var amounts = [0, 0.5, 1];
var offsets = [0, -0.5, -1];
for (var i = 0; i <= 2; i += 1) {
    var pos_x = lerp(left, right, amounts[i]) + offsets[i] * item_width;
    var wiggle = sin(current_time * 0.01 + pos_x);
    var pos_y = top + 5 * wiggle;
    var col = selectionID == i ? c_blue : c_white;
    draw_sprite_ext(katsaii_witchwanda_ui, i, pos_x, pos_y, 1, 1, 0, col, 1);
    var ui_centre_x = pos_x + item_width * 0.5;
    var ui_centre_y = pos_y + item_height * 0.5;
    var scale = lerp(0.95, 1.05, (wiggle + 1) / 2);
    var img = wandOrder[i];
    draw_sprite_ext(wandSprite, img, ui_centre_x, ui_centre_y, scale, scale, 2 * wiggle, c_white, 1);
    draw_text( ui_centre_x, ui_centre_y, img);
}
draw_circle(lerp(left, right, selectionAmount), 10, 10, false);
draw_text(10, 10, selectionID);
draw_text(10, 30, wandOrder);
draw_text(10, 50, wandCurrent);