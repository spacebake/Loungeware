
// Start the game
if !game_started {
	game_countdown --;
	if game_countdown <= 0 {
		game_started = true;
	}
}

// Game time
else {
	if !game_win and !game_lose
		game_time --;
	
	if game_time < 0 and !game_win and !game_lose {
		game_lose = true;
		game_time = 0;
		gun_lose_dir = 30;
		squish_x = 0.8;
		squish_y = 1.25;
		sfx_play(baku_chug_snd_flag, 1, 0);
		sfx_play(baku_chug_snd_lose, 1, 0);
	}
	
	if game_lose {
		gun_lose_dir = lerp(gun_lose_dir, 15, 0.1);
		game_lose_time += 0.25;
		squish_x = lerp(squish_x, 1, 0.25);
		squish_y = lerp(squish_y, 1, 0.25);
	}
	
	if game_win and game_win_time > game_win_shoot {
		squish_x = lerp(squish_x, 1, 0.1);
		squish_y = lerp(squish_y, 1, 0.1);
	}
}

// Press keys
// Only do stuff if game in progress
if (chug_value < chug_goal) and game_started and !game_win and !game_lose {

	// Get all currently held keys
	var _held_keys = [];
	if KEY_UP			array_push(_held_keys, key.up);
	if KEY_DOWN			array_push(_held_keys, key.down);
	if KEY_LEFT			array_push(_held_keys, key.left);
	if KEY_RIGHT		array_push(_held_keys, key.right);
	if KEY_PRIMARY		array_push(_held_keys, key.a);
	if KEY_SECONDARY	array_push(_held_keys, key.b);
	
	// Is only one key held?
	if (array_length(_held_keys) == 1) {
		var _key = _held_keys[0];
		
		// Is the key in our combo?
		if (_key == key_combo[0])
		or (_key == key_combo[1]) {
			
			// Is it different from the last key?
			if _key != last_key {
				
				// Chuggin' it!!!
				chug_value += chug_add;
				last_key = _key;
				swallowing = true;
				sfx_play(baku_chug_snd_swallow, 1, 0);
			}
		}
	}
}

// winner is u
if chug_value >= chug_goal and !game_lose and !game_win {
	chug_value = chug_goal;
	game_win = true;
	squish_x = 0.8;
	squish_y = 1.25;
	microgame_win();
}

// Swallow
if swallowing {
	swallow_img += swallow_spd;
	if swallow_img > swallow_max {
		swallow_img = 0;
		swallowing = false;
	}
}

// Dir value
dir_value = lerp(dir_value, (chug_value / chug_goal) * dir_goal, 0.1);
points[2].dir_self = -dir_value;
points[3].dir_self = -dir_value;
points[4].dir_self = (-dir_value * 3) - 20;

// Offsets + other lerps
gun_x_offset = lerp(gun_x_offset, 0, 0.05);
pepsi_y_offset = lerp(pepsi_y_offset, 0, 0.1);
hud_alpha = lerp(hud_alpha, 1, 0.1);

// Origin point
points[0].x		= lerp(points[0].x, 96, 0.1);
points[0].x2	= lerp(points[0].x2, 96, 0.1);
var _shake = shake_strength * (chug_value / chug_goal);
points[0].x_new		= points[0].x	+ random_range(-_shake, _shake);
points[0].y_new		= points[0].y	+ random_range(-_shake, _shake);
points[0].x2_new	= points[0].x2	+ random_range(-_shake, _shake);
points[0].y2_new	= points[0].y2	+ random_range(-_shake, _shake);

// Solve points cursedly
var _point_count = array_length(points);
for (var i = 1; i < _point_count; ++i) {
	// New XY
	points[i].x_new = points[i - 1].x2_new;
	points[i].y_new = points[i - 1].y2_new;
	
	// Dir
	points[i].dir_cum = points[i].dir_self + points[i - 1].dir_cum;
	
	// New XY2
	points[i].x2_new = points[i].x_new + lengthdir_x(points[i].point_dis, points[i].point_dir + points[i].dir_cum);
	points[i].y2_new = points[i].y_new + lengthdir_y(points[i].point_dis, points[i].point_dir + points[i].dir_cum);
}


// Game win shot
if game_win {
	game_win_time ++;
	
	// lerpy derpy
	gun_win_dir = lerp(gun_win_dir, 35, 0.25);
	gun_win_x = lerp(gun_win_x, 15, 0.25);
	
	// Flash
	game_win_flash -= 0.05;
	if game_win_time == game_win_shoot {
		game_win_flash = 1.5;
		sfx_play(baku_chug_snd_shoot, 1, 0);
	}
	
	// Cry
	if game_win_time > game_win_shoot + 60 {
		win_cry_img += 1/3;
		if win_cry_img > sprite_get_number(baku_chug_spr_cry)
			win_cry_img = sprite_get_number(baku_chug_spr_cry);
	}
	
	// Smoke
	if game_win_time > game_win_shoot and game_win_time mod 10 == 0 {
		instance_create_layer(142, 10, "Instances", baku_chug_obj_smoke);
	}
	
	// Confetti
	if game_win_time > game_win_shoot and game_win_time mod 5 == 0 {
		instance_create_layer(random_range(-8, 168), -8, "Instances", baku_chug_obj_confetti);
		instance_create_layer(random_range(-8, 168), -8, "Instances", baku_chug_obj_confetti);
	}
}