if (layer_sprite_exists("Sprites", speechSprite)) {
	var off = sin(current_time / 200) * 10;
	layer_sprite_y(clueSprite, clueY + off);
	layer_sprite_y(speechSprite, speechY + off);
}
time++;
if (!presenting) {
	var mov = KEY_RIGHT_PRESSED - KEY_LEFT_PRESSED;
	if (mov != 0) {
		if (audio_is_playing(sel_snd))
			sfx_stop(sel_snd, 0);
		sel_snd = sfx_play(mimpy_duckdate_snd_love, 0.6, false);
	}
	selection += KEY_RIGHT_PRESSED - KEY_LEFT_PRESSED;
	selection -= floor(selection / 3) * 3;
	
	if (KEY_PRIMARY_PRESSED) {
		// Present
		if (evidence[selection].index == question.answer) {
			sfx_play(mimpy_firealarm_win, 0.8, false);
			microgame_win();
		}
		else {
			sfx_play(mimpy_duckdate_snd_steal, 0.8, false);
			microgame_fail();
			layer_sprite_index(bakuSprite, 1);
		}
		instance_destroy(mimpy_objection_obj_evidence);
		
		// Object!
		objectionSprite = layer_sprite_create("Objection", VIEW_X + VIEW_W / 2 - 16, VIEW_Y + VIEW_H / 2, mimpy_objection_spr_objection);
		layer_sprite_speed(objectionSprite, 0);
		layer_sprite_index(objectionSprite, !MICROGAME_WON);
		
		// Change larold
		layer_sprite_change(laroldSprite, mimpy_objection_spr_larold_result);
		layer_sprite_speed(laroldSprite, 0);
		layer_sprite_index(laroldSprite, MICROGAME_WON);
		
		// Close clues
		layer_sprite_destroy(clueSprite);
		layer_sprite_destroy(speechSprite);
		
		// Finalize
		tm.add(new mimpy_tween(VIEW_X + VIEW_W/2 - 16, VIEW_X + VIEW_X/2 + 16, 60, tween_objection, "Jump", stop_objection));
		tm.add(new mimpy_tween(VIEW_X, 0, game_get_speed(gamespeed_fps), tween_cam_x, "EaseOut"));
		presenting = true;
	}
	
}
else if (MICROGAME_WON && time % 4 == 0) {
	var dir = random(360);
	var len = 15;
	array_push(confetti, {
		y: -len - 15,
		x: irandom_range(0, VIEW_W),
		w: lengthdir_x(len, dir),
		h: lengthdir_y(len, dir),
		color: make_color_hsv(random(255), 255, 255),
		arc: 15,
		time: 0
	});
}

tm.update();