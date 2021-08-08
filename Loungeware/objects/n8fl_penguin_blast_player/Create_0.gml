enum n8fl_penguin_blast_EPlayerAnimation{
	Idle,
	Primary,
	Secondary,
	Dodge,
	Hurt
}

image_speed = 0;
game_t = 0;

score_total = 6;
score_t = 0;

score_list = ds_list_create();

is_hurt = false;
hurt_timer = 0;

game_over = false;
did_win = false;

_init = function(){
	sfx_play(n8fl_penguin_blast_intro_snd, 0.4, 0);
}

_tick = function(){
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
		}else if(KEY_PRIMARY){
			image_index = n8fl_penguin_blast_EPlayerAnimation.Primary;	
		}else if(KEY_SECONDARY){
			image_index = n8fl_penguin_blast_EPlayerAnimation.Secondary;	
		}
	}

	game_t = clamp((TIME_MAX - TIME_REMAINING) / (TIME_MAX * 0.89), 0, 1);
	score_t = ds_list_size(score_list) / score_total;

	if(game_over == false){
		if(game_t >= 1){
			game_over = true;	
		
		
			if(score_t >= 1){
				microgame_win();	
				sfx_play(n8fl_penguin_blast_cheer_snd, 1, 0);
				did_win = true;
			}
			else
			{
				microgame_fail();	
				sfx_play(n8fl_penguin_blast_drown_snd, 1, 0);
				did_win = false;
			}
		}
	}	
}

_on_projectile_collided = function(projectile){
	var hud = n8fl_penguin_blast_hud;
	if(instance_exists(hud) == false){
		return;	
	}

	if(projectile.can_collide() == false){
		exit;	
	}
	
	if(projectile.image_index == n8fl_penguin_blast_EProjectile.Bomb){
		if(image_index == n8fl_penguin_blast_EPlayerAnimation.Dodge){
			projectile.collide_fail(id);
		}else{
			if(ds_list_size(score_list) > 0){
				ds_list_delete(score_list, 0);
				hud.make_intense();
			}
			is_hurt = true;
			projectile.collide_explode(id);
		}
		exit;
	}


	if(image_index == n8fl_penguin_blast_EPlayerAnimation.Idle){
		is_hurt = true;
		projectile.collide_fail(id);
		exit;
	}

	if(
		(image_index == n8fl_penguin_blast_EPlayerAnimation.Primary &&
		projectile.image_index == n8fl_penguin_blast_EProjectile.Primary) 
		||
		(image_index == n8fl_penguin_blast_EPlayerAnimation.Secondary &&
		projectile.image_index == n8fl_penguin_blast_EProjectile.Secondary)
	){
		ds_list_add(score_list, projectile.image_index);
		hud.make_intense();
		projectile.collide_success(id);
		exit;
	}

	projectile.collide_fail(id);
}

n8fl_execute_next_once(_init);