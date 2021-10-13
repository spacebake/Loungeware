/// @desc Draw the broom.
var t = current_time * 0.25;
var wave1 = dsin(t);
var wave2 = dsin(t + 90);
draw_sprite_ext(sprite_index, image_index, x, y - 10 + 4 * wave1, 1, 1, 10 * wave2, c_white, 1);