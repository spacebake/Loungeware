
// Background
bg_x += bg_spd_x;
bg_y += bg_spd_y;
draw_sprite_tiled_ext(baku_chug_spr_bg, 0, bg_x, bg_y, 1, 1, c_white, 1);

// Win confetti
with (baku_chug_obj_confetti) {
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

// Winner Sid
if game_win and game_win_time > game_win_shoot {
	var _shake = shake_strength / 2;
	draw_sprite_ext(baku_chug_spr_cry, win_cry_img, 96 + random_range(-_shake, _shake) - 4, 144 - 16 + random_range(-_shake, _shake), squish_x, squish_y, 0, c_white, 1);
}

// Loser Sid
else if game_lose {
	var _shake = shake_strength / 2;
	draw_sprite_ext(baku_chug_spr_spittake, game_lose_time, 100 - 16 + 4 + random_range(-_shake, _shake), 144 - 16 + random_range(-_shake, _shake), squish_x, squish_y, 0, c_white, 1);
}

// Normal Sid
else {
	// Arm
	var _arm_x = points[4].x2_new;
	var _arm_y = points[4].y2_new + pepsi_y_offset;
	var _arm_x2 = 32;
	var _arm_y2 = 320;
	var _arm_dir = point_direction(_arm_x, _arm_y, _arm_x2, _arm_y2) + 90 - (dir_value / 2);
	draw_sprite_ext(baku_chug_spr_sid_arm, 0, _arm_x, _arm_y, 1, 1, _arm_dir, c_white, 1);
	
	// Bodyparts
	var _bodypart_count = array_length(bodyparts);
	for (var i = 0; i < _bodypart_count; ++i) {
		var _part = bodyparts[i];
		var _point = points[_part.point];
		
		// Swallow
		var _img = 0;
		if _part.spr == baku_chug_spr_profile_neck {
			_img = swallow_img;
		}
		
		// Pepsi y offset
		var _y_offset = 0;
		if _part.spr == baku_chug_spr_pepsi {
			_y_offset = pepsi_y_offset;
		}
		
		// Draw sprite
		draw_sprite_ext(_part.spr, _img, _point.x_new, _point.y_new + _y_offset, 1, 1, _point.dir_cum, c_white, 1);
	}
	
	// Bones
	// var _point_count = array_length(points);
	// for (var i = 0; i < _point_count; ++i) {
	// 	var _point = points[i];
	// 	draw_line_width_colour(_point.x_new, _point.y_new, _point.x2_new, _point.y2_new, 2, c_blue, c_white);
	// }
}

// Gun smoke
with baku_chug_obj_smoke {
	draw_self();
}

// Gun
var _wobble = sin(current_time / 500) * 4;
if game_win or game_lose _wobble = 0;
var _spr = baku_chug_spr_gun;
if game_lose _spr = baku_chug_spr_gun_flag;
draw_sprite_ext(_spr, 0, 180 + gun_x_offset - gun_win_x, 107, 1, 1, -25 + _wobble - gun_win_dir - gun_lose_dir, c_white, 1);

// Corner HUD
draw_sprite_ext(baku_chug_spr_hud, 0, 0, 0, 1, 1, 0, c_white, 0.5);

// Keys to press
if game_started and !game_win and !game_lose {
	var _key_x = -3;
	var _key_y = -2;
	draw_sprite(baku_chug_spr_key, key_img[0], _key_x, _key_y);
	_key_x += 22;
	draw_sprite(baku_chug_spr_key, key_img[1], _key_x, _key_y);
}

// Win msg
if game_win and game_win_time > game_win_shoot {
	draw_sprite(baku_chug_spr_win, 0, 0, 0);
}

// Lose msg
if game_lose {
	draw_sprite(baku_chug_spr_lose, 0, 0, 0);
}

// Win flash
if game_win {
	draw_sprite_stretched_ext(baku_chug_spr_pixel, 0, 0, 0, 999, 999, 0xe0ffff, game_win_flash);
}

// Debug
// draw_set_colour(c_white);
// draw_text(8, 32, string(chug_value) + " / " + string(chug_goal));
// draw_text(8, 32, string(game_time));