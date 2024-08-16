// sandveech_bg_obj_lose_screen.step

ray_angle += 3;

offsety = anchorY + sin(timer * frequency) * amplitude;
timer++;

if (sandveech_bg_obj_game.alarm[0] == 60) {
	sfx_play(sandveech_bg_snd_nom);
	burger_spr = 1;
}