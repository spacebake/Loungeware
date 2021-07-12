_transform = new n8fl_FTransform(x, y);

_track_sprite = n8fl_escape2_tracks_spr;

_init = function(){
	_transform.set_parent(inst_n8fl_escape3_game.get_fake_camera_transform());
}

_tick = function(){
	var pos = _transform.get_pos();
	pos._x -= n8fl_escape3_game.get_travel_speed();
	_transform.set_pos_v(pos);
}

_draw = function(){
	var _x = _transform.get_x() % room_width;
	draw_sprite(_track_sprite, 0, _x, _transform.get_y());
	draw_sprite(_track_sprite, 0, _x + room_width, _transform.get_y());
	draw_sprite(_track_sprite, 0, _x - room_width, _transform.get_y());
}

n8fl_execute_next_once(_init);