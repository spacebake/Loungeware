/// @description PLAY OUT GAME

//Check inputs
if ((KEY_PRIMARY_PRESSED or KEY_SECONDARY_PRESSED) && MICROGAME_WON = false) {
	input_arr = [KEY_SECONDARY, KEY_PRIMARY]
	//Right input
	if (input_arr[0] = norrispos[0] && input_arr[1] = norrispos[1]) {
		count --
		norrisy += 150
		ddprompt = "again"
		ddprompt_timer = 14
		ddprompt_flash = 2
		sfx_play(ddgang_garyflip_click, 1, false)
		if (norrispos[0] = true) { input_button_time[0] = 10 } else { input_button_time[1] = 10 }
		//Win
		if (count = 0) {
			microgame_win()
			sfx_play(ddgang_garyflip_yippee, 1, false)
			norrispos = [1, 1]
			var gem = instance_create_layer(room_width / 2, -100, "mineral", ddgang_garyflip_mineral)
			ddprompt = "Gary thinks you're chill"
			ddprompt_timer = 120
			ddprompt_flash = 2
		//Continue
		} else { reroll() }
	} else if (!instance_exists(ddgang_garyflip_mineral)) {
		var gem = instance_create_layer(room_width / 2, -100, "mineral", ddgang_garyflip_mineral)
		gem.image_index = 1
		ddprompt = "Gary's mad. Not cool."
		ddprompt_timer = 120
		ddprompt_flash = 2
		norrispos = [0, 0]
	}
	//Reset
	input_arr = [false, false]
}

//End early
if (instance_exists(ddgang_garyflip_mineral)) {
	win_timer --
	if (win_timer = 0) { microgame_end_early() }
}
//Pressed time decrease
input_button_time[0] = max(input_button_time[0] - 1, 0)
input_button_time[1] = max(input_button_time[1] - 1, 0)