if (state == "start_game"){
	var _current_game_data = variable_struct_get(___global.microgame_metadata, microgame_keylist[cursor]);
	with(instance_create_layer(0, 0, layer, ___MG_MNGR)){
		___state_change("game_switch");
		___global.difficulty_level = other.difficulty;
		force_substate = 5;
		cart_sprite = ___cart_sprite_create(_current_game_data);
		microgame_next_name = other.microgame_keylist[other.cursor];
		microgame_next_metadata = _current_game_data;
		gb_scale = gb_min_scale;
		gallery_mode = true;
		gallery_first_pass = true;
	}
	___global.menu_cursor_gallery = cursor;
	instance_destroy();
}