
if (smoke_timer <= 0) && (state != "air"){
	smoke_timer = smoke_timer_max;
	var _smoke_dir = image_angle + 194;
	var _smoke_rad = 10;
	var _smoke_x = x + lengthdir_x(_smoke_rad, _smoke_dir)
	var _smoke_y = y + lengthdir_y(_smoke_rad, _smoke_dir)
	instance_create_layer(_smoke_x, _smoke_y, layer, space_scooter_obj_smoke);

}
smoke_timer--;

if (compress_timer){
	var _compress_y_offset = 1;
	rabbit_frame = 4;
	if (compress_timer <= 4) rabbit_frame = 3;
	compress_timer = max(0, compress_timer - 1);


} else {
	var _compress_y_offset = 0;
	if (state == "floor") rabbit_frame = 2;
}

if (y >= 43 && image_angle != 0 && !lock_cam_y && state == "floor"){
	var _rabbit_y_offset = -2;
	rabbit_frame = 3;
} else {
	var _rabbit_y_offset = 0;
}

if (state == "air") rabbit_frame = 5;
if (state == "lose_anim" && wait <= 0) rabbit_frame = 6;

// draw scooter
if (state != "crashing" && state !="win_anim_2") draw_sprite_ext(space_scooter_spc_scooter_body, rabbit_frame, x, y + _compress_y_offset + _rabbit_y_offset, 1, 1, image_angle, c_white, 1);
draw_sprite_ext(space_scooter_spc_scooter_body, 1, x, y, 1, 1, image_angle, c_white, 1);
draw_sprite_ext(space_scooter_spc_scooter_body, body_frame, x, y + _compress_y_offset, 1, 1, image_angle, c_white, 1);

//draw_set_color(c_white);
//draw_set_font(fnt_frogtype);

//draw_text_transformed(VIEW_X + 3, 3, "x: " + string(x), 0.25, 0.25, 0);
//draw_text_transformed(VIEW_X + 3, 10, "y: " + string(y), 0.25, 0.25, 0);
//draw_text_transformed(VIEW_X + 3, 17, "img angle: " + string(image_angle), 0.25, 0.25, 0);

//draw_text_transformed(VIEW_X + 3, 24, "checker1y: " + string(checker1.y), 0.25, 0.25, 0);
//draw_set_color(c_red);
//draw_rectangle_fix(checker1.x, checker1.y, checker1.x + 1, checker1.y+1);
//draw_rectangle_fix(checker2.x, checker2.y, checker2.x + 1, checker2.y+1);

if (cam_x + VIEW_W > room_width){
	draw_set_color(floor_col);
	draw_rectangle_fix(VIEW_X, (room_height) - 16, VIEW_X + VIEW_W, room_height);
}


