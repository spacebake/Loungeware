headdir += 3;
spotlight_dir += 2;

mouse_in_canvas = point_in_rectangle(mouse_x, mouse_y, button_x1, button_y1, button_x2, button_y2);
button_hover = ___smooth_move(button_hover, mouse_in_canvas, 0.0025, 3);

if (mouse_in_canvas){
	window_set_cursor(cr_handpoint);
} else {
	window_set_cursor(cr_default);
}

//------------------------------------------------------------------------

//------------------------------------------------------------------------
if (state = "active_check"){
	if (step <= 5 && audio_system_is_available()){
		state = "fly_up";
		fadeout_alpha = 1;
		show_debug_message("audio system alraedy active. skipping clickscreen...");
	} else if (step > 5){
		state = "choose";
	}
}

//------------------------------------------------------------------------
// STATE | CHOOSE
//------------------------------------------------------------------------
if (state == "choose"){
	light_val = min(1, light_val + (1/10));
	yy_mod = ___smooth_move(yy_mod, 0, 1, 8);

	if (audio_system_is_available() && !confirmed){
		confirmed = true;
		wait = 8;
	}
	
	if (confirmed && wait <= 0){
		menu_play_lw();
	}
	wait--;
}

// -----------------------------------------------------------------------
// STATE | FLY UP
//------------------------------------------------------------------------
if (state == "fly_up"){
	button_zoomscale = max(0, button_zoomscale - (1/15));
	
	if (KEY_PRIMARY_PRESSED){
		fadeout_alpha = 1;
	}
	larold_frame = min(larold_frame + 0.2, 3);
	larold_y_mod += larold_vsp;
	larold_vsp -= 0.2;
	fadeout_alpha = min(1, fadeout_alpha + (1/90));
	if (fadeout_alpha >= 1){
		audio_stop_all();
		if (room_goto_after != noone) room_goto(room_goto_after);
		if (object_create_after != noone) instance_create_layer(0, 0, layer, object_create_after);
		window_set_cursor(cr_default);
		instance_destroy();
	}
}

if (screenshake > 0){
	screenshake--;
	var sv = 2;
	if (screenshake <= 0) sv = 0;
	shake_x = random_range(-sv, sv);
	shake_y = random_range(-sv, sv);
}


step++;