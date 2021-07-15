/// @description fall

if timer > 0 {
	vspeed = 0;
	timer--	
	if timer==0 {
		vspeed = .85+DIFFICULTY*.1;	
	}
}

if anti_hats_obj_dude.won == 0 {
	if y>room_height*.3 && !swapped && image_index==0 && tooeasy {
		var left = instance_place(x-30,y,anti_hats_obj_hat);
		var right = instance_place(x+30,y,anti_hats_obj_hat);
		var change = choose(left,right);
		if change==noone {
			change = left==noone ? right : left;
		}
		if change != noone {
			swapx = change.x;
			change.swapx = x;
			swapped = true;
		}
	}
	
	x = lerp(x,swapx,.4);
	
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
			anti_hats_obj_dude.loserhat = image_index;
		}
		sfx_play(anti_hats_snd_lose,1.6,false);
		instance_destroy();
	}
}
else if anti_hats_obj_dude.won == 1 {
	vspeed += .2;
}
image_angle = sin(current_time/(200-(tooeasy*150*(image_index==0))))*8; //wave, faster to indicate a switch
if y>room_height+20 {
	instance_destroy();	
}
