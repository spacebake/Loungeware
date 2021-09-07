/// @description Insert description here
// You can write your code in this editor

music_volume = .3;
microgame_music_start(sam_cd_msc_theme, music_volume, false);

fish = sam_cs_obj_fish;
paw = sam_cs_obj_paw;
ending = sam_cs_obj_ending;
ending.visible = false;

ending.image_speed = 0;

phase_counter = 0;

fish_speed = 2 + DIFFICULTY*1.5;

phase1 = function() {
	fish.image_angle += fish_speed;
	if KEY_PRIMARY_PRESSED
	{
		sfx_play(sam_cs_snd_cat_swipe, .7, false)
		phase = phase2;
	}
}

phase2 = function() {
	paw.image_index = 1;
	var _angle = (fish.image_angle + 180) mod 360;
	if _angle > 135
	and _angle < 225
	{
		microgame_win();
		ending.image_index = 0;
	}
	else
	{
		microgame_fail();
		ending.image_index = 1;
	}
	
	phase = phase3;
}

phase3 = function() {
	phase_counter += 1;
	if phase_counter = room_speed * .5
	{
		ending.visible = true;
		phase = phase4;
	}
}

phase4 = function() {
	phase_counter += 1;
	if phase_counter = room_speed * 1.5
		microgame_end_early();
}

phase = phase1;