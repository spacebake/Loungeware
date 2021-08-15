x = room_width / 2 - sprite_get_width(tfg_swipe_spr_top) / 2 + pos;
y = room_height / 2;

if (KEY_RIGHT || KEY_PRIMARY || KEY_SECONDARY)
	spd += 2;
else {
	spd = lerp(spd, 0, 0.2);
	pos = lerp(pos, 0, 0.03);
}

pos = tfg_approach(pos, sprite_get_width(tfg_swipe_spr_top), spd);

if (pos == sprite_get_width(tfg_swipe_spr_top)) {
	
	if (spd > range.min && spd < range.max && !swiped) {
		sfx_play(tfg_swipe_snd_succ, 1, false);
		microgame_win();
		
	} else if (spd > range.max && !swiped) {
		log("too fast", spd)
		sfx_play(tfg_swipe_snd_fail, 1, false);
		
	} else if (spd < range.min && !swiped) {
		log("too slow", spd)
		sfx_play(tfg_swipe_snd_fail, 1, false);
	}
	
	swiped = true;
	
} else {
	swiped = false;
}
