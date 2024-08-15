if (TIME_REMAINING_SECONDS > 2) {
	for (var i = 0; i < array_length(order_list); i++) {
		var _spr = 0
	
		switch (order_list[i]) {
			case sandveech_bg_obj_buns:
				_spr = 1;
				break;
			case sandveech_bg_obj_cheese:
				_spr = 2;
				break;
			case sandveech_bg_obj_ketchup:
				_spr = 3;
				break;
			case sandveech_bg_obj_lettuce:
				_spr = 4;
				break;
			case sandveech_bg_obj_mayo:
				_spr = 5;
				break;
			case sandveech_bg_obj_onion:
				_spr = 6;
				break;
			case sandveech_bg_obj_patty:
				_spr = 7;
				break;
			case sandveech_bg_obj_pickle:
				_spr = 8;
				break;
			case sandveech_bg_obj_tomato:
				_spr = 9;
				break;
		}
	
		draw_sprite_ext(sandveech_bg_spr_icon, _spr, 32 + 48 * i, room_height - 32, icon_size, icon_size, 0, c_white, 1);
	}
}

icon_size = lerp(icon_size, 1, 0.09);