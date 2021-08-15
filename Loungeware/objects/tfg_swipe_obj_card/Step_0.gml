x = room_width / 2 - sprite_get_width(tfg_swipe_spr_top) / 2 + pos;
y = room_height / 2;

if (KEY_RIGHT || KEY_PRIMARY || KEY_SECONDARY)
	spd += 2;
else {
	spd = lerp(spd, 0, 0.2);
	pos = lerp(pos, 0, 0.03);
}

pos = tfg_approach(pos, sprite_get_width(tfg_swipe_spr_top), spd);


if (inc_curr++ % inc_every == 0) {
	flipflop = !flipflop;
}


if (text == succ_text) exit;

if (pos == sprite_get_width(tfg_swipe_spr_top)) {
	
	if (spd > range.min && spd < range.max && !swiped) {
		sfx_play(tfg_swipe_snd_succ, 1, false);
		microgame_win();
		text = succ_text;
		
	} else if (spd > range.max && !swiped) {
		sfx_play(tfg_swipe_snd_fail, 1, false);
		text = fast_text;
		
	} else if (spd < range.min && !swiped) {
		sfx_play(tfg_swipe_snd_fail, 1, false);
		text = slow_text;
	}
	
	swiped = true;
	
} else {
	swiped = false;
}

tfg_swipe_obj_game.index = text == succ_text ? 1 : 0;