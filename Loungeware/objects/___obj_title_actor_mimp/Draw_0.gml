

var _draw_x = x;
var _draw_y = y;

if (mimpy_shake > 0){
	var _sv = 4;
	_draw_x += random_range(-_sv, _sv);
	_draw_y += random_range(-_sv, 0);
}

draw_sprite_ext(sprite_index, image_index, _draw_x, _draw_y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
draw_sprite(___spr_title_net, net_frame, net_x, floor_y);


if (draw_logo) draw_cover_logo();

draw_smoke_part();