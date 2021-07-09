_track_sprite = n8fl_escape2_tracks_spr;



_init = function(){
	
}

_tick = function(){
	x+= n8fl_escape2_game.get_travel_speed();
}

_draw = function(){
	var _x = x % room_width;
	draw_sprite(_track_sprite, 0, _x, y);
	draw_sprite(_track_sprite, 0, _x + room_width, y);
	draw_sprite(_track_sprite, 0, _x - room_width, y);
}

_init();