var w = sprite_get_width(tfg_swipe_spr_top);
var w_half = w / 2;
var h = sprite_get_width(tfg_swipe_spr_top) / 2;
var h_half = h / 2;


draw_sprite(tfg_swipe_spr_bottom, 0, room_width / 2 - w_half,
	room_height / 2 - h_half);

with (tfg_swipe_obj_card) {
	draw();
}

draw_sprite(tfg_swipe_spr_top, index, room_width / 2 - w_half, 
	room_height / 2 - h_half);
	

