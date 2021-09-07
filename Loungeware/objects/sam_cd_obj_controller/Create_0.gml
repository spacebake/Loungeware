/// @description Insert description here
// You can write your code in this editor

win_sounds = [sam_cd_snd_delicious, sam_cd_snd_milky_cookie, sam_cd_snd_thats_it, sam_cd_snd_you_did_it, sam_cd_snd_you_dunked];
lose_sounds = [sam_cd_snd_dont_want, sam_cd_snd_dunk_better, sam_cd_snd_not_like, sam_cd_snd_you_didnt];
voice_volume = .4;
music_volume = .3;

try_sound = sfx_play(sam_cd_snd_try_to, voice_volume, false);

cookie = sam_cd_obj_cookie_hand;
milk = sam_cd_obj_milk;

cookie_crane_speed = 5 + 15* (DIFFICULTY/5);
cookie_drop_speed = 16;

phase_counter = 0;

phase1 = function() {
	cookie.x += cookie_crane_speed;
	if cookie.bbox_right >= room_width
	{
		phase = phase2;	
	}
	
	if KEY_PRIMARY
		phase = phase3;
}

phase2 = function() {
	cookie.x -= cookie_crane_speed;
	if cookie.bbox_left <= 0
	{
		phase = phase1;	
	}
	
	if KEY_PRIMARY
		phase = phase3;
}

phase3 = function() {

	with cookie
	{
		repeat(other.cookie_drop_speed)
		{
			if !place_meeting(x, y + 1, sam_cd_obj_barrier)
			{
				y += 1;
			}
			else
			{
				if x > 207
				and x < 300
				and y > 250
				{
					microgame_win();
					with other
					{
						phase = phase4;
						sfx_stop(try_sound, 0);
						sfx_play(win_sounds[irandom(array_length(win_sounds)-1)], voice_volume, false);
					}
					break;
				}
				else
				{
					var lay_id = layer_get_id("Background");
					var back_id = layer_background_get_id(lay_id);
					    layer_background_sprite(back_id, sam_cd_spr_background2);
					microgame_fail();
					with other
					{
						phase = phase4;
						sfx_stop(try_sound, 0);
						sfx_play(lose_sounds[irandom(array_length(lose_sounds)-1)], voice_volume, false);
					}
					break;
				}
			}
		}
	}
	
}

phase4 = function() {
	phase_counter += 1;
	if phase_counter = room_speed * 3
		microgame_end_early();
}
phase = phase1;