var left = 0;
var top = 0;
var right = room_width;
var bottom = room_height;
var midx = mean(left, right);
var midy = mean(top, bottom);
var avatar_img = sin(current_time * 0.005) > 0;
draw_sprite(katsaii_witchwanda_avatar, avatar_img, midx + irandom_range(-1, 1), bottom);
var item_width = sprite_get_width(katsaii_witchwanda_ui);
var amounts = [0, 0.5, 1];
var offsets = [0, -0.5, -1];
for (var i = 0; i <= 2; i += 1) {
    var pos = lerp(left, right, amounts[i]) + offsets[i] * item_width;
    draw_sprite(katsaii_witchwanda_ui, i, pos, top + 5 * sin(current_time * 0.01 + pos));
}