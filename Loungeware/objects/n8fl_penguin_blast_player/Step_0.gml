if(is_hurt){
	hurt_timer++;
	image_alpha = hurt_timer % 6  == 0 ? 1 : 0.5;
	//image_blend = hurt_timer % 6  == 0 ? c_white : c_red;
	image_index = n8fl_penguin_blast_EPlayerAnimation.Hurt;
	if(hurt_timer > 12){
		hurt_timer = 0;	
		image_alpha = 1;
		image_blend = c_white;
		is_hurt = false;
	}
}else if(!game_over){
	image_index = n8fl_penguin_blast_EPlayerAnimation.Idle;

	if(KEY_DOWN){
		image_index = n8fl_penguin_blast_EPlayerAnimation.Dodge;	
	}else if(KEY_SECONDARY){
		image_index = n8fl_penguin_blast_EPlayerAnimation.Primary;	
	}else if(KEY_PRIMARY){
		image_index = n8fl_penguin_blast_EPlayerAnimation.Secondary;	
	}
}

game_t = clamp((TIME_MAX - TIME_REMAINING) / (TIME_MAX * 0.9), 0, 1);
score_t = ds_list_size(score_list) / score_total;

if(game_over == false){
	if(game_t >= 1){
		game_over = true;	
		
		
		if(score_t >= 1){
			microgame_win();	
			did_win = true;
		}
		else
		{
			microgame_fail();	
			did_win = false;
		}
	}
}