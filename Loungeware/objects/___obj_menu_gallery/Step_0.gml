if (state == "start_game"){

	___microgame_load_gallery_version(microgame_keylist[cursor], difficulty);
	___global.menu_cursor_gallery = cursor;
	instance_destroy();
}


button_guide_alpha = ___toggle_fade(button_guide_alpha, button_guide_show, 10);

// ---------------------------------------------------------
if (state == "fadeout_back"){
	close_circle_prog = max(0, close_circle_prog - (1/20));
	if (close_wait_before > 0){
		close_wait_before -=1;
	} else {
		if (close_circle_prog <= 0) close_wait--;
		if (close_wait <= 0 && !fadeout_ended){
			fadeout_do();
			fadeout_ended = true;
		}
	}
}