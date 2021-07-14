/// @description fall



if anti_hats_obj_dude.won == 0 {
	if place_meeting(x,y,anti_hats_obj_dude) {
		if image_index==0 { //won
			anti_hats_obj_dude.won = 1;
			anti_hats_obj_dude.image_index = 1;
			anti_hats_obj_score.visible = true;
			anti_hats_obj_score.image_index = 0;
			with anti_hats_obj_hat {
				hspeed = sign(x-anti_hats_obj_dude.x)*random_range(3,4);
				vspeed = -random_range(3,4);
			}
			sfx_play(anti_hats_snd_win,1.2,false);
			microgame_win();
		}
		else { //lost
			anti_hats_obj_dude.won = -1;
			anti_hats_obj_dude.image_index = 2;
			anti_hats_obj_score.visible = true;
			anti_hats_obj_score.image_index = 1;
		}
		sfx_play(anti_hats_snd_lose,1.6,false);
		instance_destroy();
	}
}
else if anti_hats_obj_dude.won == 1 {
	vspeed += .2;
}
image_angle = sin(y/10)*8; //wave
if y>room_height+20 {
	instance_destroy();	
}