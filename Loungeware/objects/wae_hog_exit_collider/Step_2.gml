/// @description Insert description here
// You can write your code in this editor
if instance_place(x,y,wae_hog_for_babies) != -4
{
	if instance_number(wae_hog) != 0
	{
	var wh = wae_hog
	}
	else
	{
		var wh = wae_hog_for_babies
	}
	if wh.wae_hog_state == "running"
	{
		wh.wae_hog_state = "escape"
		microgame_win()
		sfx_play(objfrog_pp_sfx_yeehawww,0.5,false)
		repeat DIFFICULTY*DIFFICULTY
		{
			instance_create_depth(x,y,0,wae_hog_angry_farmer_anim)
		}
	}
}

