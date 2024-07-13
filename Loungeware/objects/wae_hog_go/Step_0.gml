/// @description Insert description here
// You can write your code in this editor
if instance_number(wae_hog) != 0
{
	var wh = wae_hog
}
else
{
	var wh = wae_hog_for_babies
}
if instance_exists(wh)
{
	if wh.wae_hog_framecount >  wh.wae_hog_init_waitframes / 3 and image_index == 0
	{
		image_index = 1
		sfx_play(wae_hog_beep,1,false)
	}
	if wh.wae_hog_framecount > 2* wh.wae_hog_init_waitframes /3 and image_index == 1
	{
		image_index = 2
		sfx_play(wae_hog_beep,1,false)
	}
	if wh.wae_hog_framecount > 3* wh.wae_hog_init_waitframes /3 and image_index == 2
	{
		image_index = 3
		sfx_play(wae_hog_beep,1,false)
	}
	if wh.wae_hog_framecount > 4* wh.wae_hog_init_waitframes /3 and image_index == 3
	{
		image_index = 4
		
		sfx_play(wae_hog_beep2,1,false)
		
	}
		if wh.wae_hog_framecount > 7* wh.wae_hog_init_waitframes /3 and image_index == 4
	{
		if instance_exists(wae_hog_arrowkeys)
		{
			instance_destroy(wae_hog_arrowkeys)
		}
		instance_destroy(self)
		
	}
}