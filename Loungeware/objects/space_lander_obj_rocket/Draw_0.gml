if (state == "invisible"){
	draw_sprite(space_lander_spr_indicator, (vsp <= land_speed_max), (VIEW_W/2),  (152));
	exit;
}

if (ship_shake){
	var _sv = ship_shake_val;
	var _sx = random_range(-_sv,_sv);
	var _sy = random_range(-_sv,_sv);
	ship_shake = max(0, ship_shake - 1);

} else {
	var _sx = 0;
	var _sy = 0;
}

//draw ship
var _ship_x = x + _sx;
var _ship_y = y + _sy;


if (state == "pause" || state == "flying" || state == "fail"){

	draw_sprite(space_lander_spr_rocket, ship_index, _ship_x, _ship_y);

	// draw flame
	if (thrusting){
		flame_timer--;
		if (flame_timer <= 0){
			flame_timer = flame_timer_max;
			var _store_flame_img = flame_img;
			while (flame_img == _store_flame_img){
				flame_img = irandom(sprite_get_number(space_lander_spr_flame)-1);
			}
		}
		draw_sprite(space_lander_spr_flame, flame_img, _ship_x, _ship_y);
	}
}



if (state == "won"){
	draw_sprite(space_lander_spr_rocket, 5, _ship_x, _ship_y + alien_y_mod);
	draw_sprite(space_lander_spr_rocket, 2, _ship_x, _ship_y);
	draw_sprite_ext(space_lander_spr_rocket, lid_frame, _ship_x + lid_x_mod, _ship_y, 1, 1, lid_dir, c_white, 1);
}



// draw landing area
draw_sprite(space_lander_spr_bg, 1, 0, 0);



draw_sprite(space_lander_spr_indicator, (vsp <= land_speed_max), (VIEW_W/2),  (152));
