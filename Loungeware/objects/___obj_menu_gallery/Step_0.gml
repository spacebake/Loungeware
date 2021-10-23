if (state == "start_game"){

	___microgame_load_gallery_version(microgame_keylist[cursor], difficulty);
	___global.menu_cursor_gallery = cursor;
	instance_destroy();
}


button_guide_alpha = ___toggle_fade(button_guide_alpha, button_guide_show, 10);