/// @description Game loop
if (start_game){
	if (key_count >= key_sequence_lenght){
		chacon_not_enough_tacos_glasses.visible = false;
		chacon_not_enough_tacos_larold.image_index = 2;
		with(chacon_not_enough_tacos_light){
			if (alarm[0] == -1){
				alarm[0] = game_get_speed(gamespeed_fps) * time;
			}
		}
		microgame_win();
	} else {
		if (KEY_ANY_RELEASED) {	  
			ShakeObject(chacon_not_enough_tacos_glasses, true);
			Screenshake(5, 1, 1);
			
			if (KeyMatch()) { // If right key is pressed
				sprite_alpha[key_count] = 1; // Make correct key pressed visible
				sprite_color = make_color_rgb(181,255,208); // Change button color to green
				key_count++; // Keep count of combo sequence
				
				ShakeObject(chacon_not_enough_tacos_trompo); // Shake trompo
				CreateSlash();
			}  else{
				draw_x = true; // Draw red X
				microgame_fail();
				start_game = false; // Disable key pressing
				chacon_not_enough_tacos_larold.image_index = 1;
			}
		}
	}
}

show_debug_message(sprite_alpha[2])