draw_sprite(space_scooter_spr_stars, 0, VIEW_X, VIEW_Y);

var _x = (VIEW_X * 0.99);
var _y =( VIEW_Y * 0.99) + 5;

draw_sprite(space_scooter_spr_stars, 3, _x, _y);
draw_sprite(space_scooter_spr_stars, 3, _x + VIEW_W, _y);


draw_sprite(space_scooter_spr_stars, 1, VIEW_X * 0.95, VIEW_Y * 0.95);
draw_sprite(space_scooter_spr_stars, 1, (VIEW_X * 0.95) + VIEW_W, VIEW_Y * 0.95);

// draw big rabbit
if (space_scooter_obj_scooter.is_perfect){
	var _x = (VIEW_X * 0.92) + 68;
	var _y = (VIEW_Y * 0.92) - 5;
	draw_sprite(space_scooter_spr_big_rabbit, big_rabbit_frame, _x, _y);
	if (big_rabbit_play) big_rabbit_frame = min(sprite_get_number(space_scooter_spr_big_rabbit)-1, big_rabbit_frame + big_rabbit_speed);
	if (big_rabbit_play && !shook2){
		shook2 = true;
		space_scooter_obj_scooter.shake = 10;
	}

	if (big_rabbit_frame >= 10 && !shook){
		space_scooter_obj_scooter.shake = 5;
		shook = true;
	}
}

var _x = (VIEW_X * 0.9);
draw_sprite(space_scooter_spr_stars, 2, _x, VIEW_Y*0.9);
draw_sprite(space_scooter_spr_stars, 2, _x + VIEW_W, VIEW_Y*0.9);

if (VIEW_X + VIEW_W > room_width){
	draw_set_color(floor_col);
	draw_rectangle_fix(VIEW_X-1, room_height - 24, VIEW_X + VIEW_W+1, room_height);
}
