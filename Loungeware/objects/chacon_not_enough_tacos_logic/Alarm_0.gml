/// @description Start and hide generated sequence
for (var i = 0; i < key_sequence_length; i++){
    sprite_alpha[i] -= fade_intensity; // Decrease alpha for each sprite
}

// Check generated sequence buttons alpha, if it's not visible anymore, start game
if (sprite_alpha[0] >= 0){
    alarm[0] = game_get_speed(gamespeed_fps) * 0.05;
} else{
	start_game = true;
	if (audio_is_playing(chacon_not_enough_tacos_sound_clock)){
		sfx_stop(chacon_not_enough_tacos_sound_clock)
	}
	
	sfx_play(chacon_not_enough_tacos_sound_bell);
}


