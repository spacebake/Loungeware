key_sequence_length = 4;
key_sequence = noone;
key_count = 0;

sprite_subimage = 0;

sprite_alpha = array_create(key_sequence_length, 1);
fade_intensity = 0.3;

show_sequence_time = 1.5;
start_game = false;

sprite = noone;
sprite_color = c_white;

x_offset = 0;
scale = 1;

draw_x = false;

all_sequence_sprites[0] = noone;
draw_correct_key = false;

alarm[0] = game_get_speed(gamespeed_fps) * show_sequence_time;

// Create sequence
for (var i = 0; i < key_sequence_length; i++){
	key_sequence[i] = choose(vk_left, vk_right, vk_up, vk_down, ord("Z"), ord("X"));
}

// Check if key pressed matches the sequence
function KeyMatch(){

	var _left_match = KEY_LEFT_RELEASED && key_sequence[key_count] == vk_left;
	var _right_match = KEY_RIGHT_RELEASED && key_sequence[key_count] == vk_right; 
	var _up_match = KEY_UP_RELEASED && key_sequence[key_count] == vk_up
	var _down_match = KEY_DOWN_RELEASED && key_sequence[key_count] == vk_down; 
	var _primary_match = KEY_PRIMARY_RELEASED && key_sequence[key_count] == ord("Z");
	var _secondary_match = KEY_SECONDARY_RELEASED && key_sequence[key_count] == ord("X");
	
	return _left_match || _right_match || _up_match || _down_match || _primary_match || _secondary_match;
}