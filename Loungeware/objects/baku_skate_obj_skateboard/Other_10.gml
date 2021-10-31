
// Draw shadow
var _shadow_scale = clamp(map(jump_y, 0, -128, 1, 0.5), 0.5, 1);
draw_sprite_ext(shadow_sprite, 0, board_x, board_y, _shadow_scale, _shadow_scale, 0, c_white, 1);