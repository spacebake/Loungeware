// difficulty switcher for test mode
for (var i = 1; i <= 5; i++){
	if (keyboard_check_pressed(ord(string(i)))){
		___global.difficulty_level = i;
		___dev_save();
		workspace_end();
		game_restart();
	}
}

// restart R
if (keyboard_check_pressed(ord("R"))){
	workspace_end();
	game_restart();
}

// cart preview
if (keyboard_check_pressed(ord("T"))){
	if (___MG_MNGR.state != "cart_preview"){
		room_goto(___rm_restroom);
		with(___MG_MNGR) ___state_change("cart_preview");
	} else {
		workspace_end();
		game_restart();
	}
}

// toggle debug
if (keyboard_check_pressed(ord("Y"))){
	debug_hidden = !debug_hidden;
	___dev_save();
}

// toggle mute
if (keyboard_check_pressed(ord("M"))){
	muted = !muted;
	audio_set_master_gain(0, !muted);
	___dev_save();
} 

// infinite timer
if (keyboard_check_pressed(ord("I"))){
	infinite_timer = !infinite_timer;
	___dev_save();
} 
if (infinite_timer){
	with (___MG_MNGR) microgame_timer = microgame_timer_max;
}