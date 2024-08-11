// sandveech_bg_obj_lose_screen.step

ray_angle += 3;

offsety = anchorY + sin(timer * frequency) * amplitude;
timer++;

if (TIME_REMAINING_SECONDS == 1) {
	sfx_play(sandveech_bg_snd_nom);
	burger_spr = 1;
}