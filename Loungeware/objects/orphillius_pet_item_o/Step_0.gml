var dir=point_direction(x,y,pet.x,pet.y)
var dist=point_distance(x,y,pet.x,pet.y)
var scale=game.drawscale
if dist<4 or anim=1{
	anim=1
	switch sprite_index{
		case orphillius_pet_food_s:
			switch anim_phase{
				case 0:
					if game.request=orphillius_pet_food_s{	//food eaten (success)
						pet.image_index=1
						game.request=noone
						game.action_c=0
						sfx_play(orphillius_sfx_crunch,gain)
						repeat(6){	//creates bits
							with instance_create_depth(pet.x,pet.y,pet.depth-10,orphillius_pet_egg_o){
								image_index=irandom_range(3,6)
								image_xscale=scale
								image_yscale=scale
								direction=choose(irandom_range(15,45),irandom_range(120,135))
								speed=irandom_range(8,10)
								gravity=.1
							}
						}
						instance_destroy(id);exit
					}else{		//wrong item used
						if !MICROGAME_WON{
							sfx_play(orphillius_sfx_boing,gain)
							sfx_play(orphillius_sfx_pet_cry,gain)
						}
						speed=16
						direction=90+choose(-20,20)
						friction=0
					}
					anim_phase+=1
				break
				case 1: anim_c+=1; if anim_c>end_anim_dur{instance_destroy(id);exit};break
			}
		break
		case orphillius_pet_play_s:
			switch anim_phase{
				case 0:
					if game.request=orphillius_pet_play_s{	//ball bounced by pet (success)
						pet.image_index=1
						game.request=noone
						game.action_c=0
						anim_phase+=2
						end_dir=choose(45,135)+irandom_range(-10,10)
						sfx_play(orphillius_sfx_ball_hit,gain)
					}else{		//wrong item used
						if !MICROGAME_WON{
							sfx_play(orphillius_sfx_boing,gain)
							sfx_play(orphillius_sfx_pet_cry,gain)
						}
						speed=16
						direction=90+choose(-20,20)
						friction=0
						anim_phase+=1
					}
					
				break
				case 1: anim_c+=1; if anim_c>end_anim_dur{instance_destroy(id);exit};break	//bounces up
				case 2: anim_c+=1; if anim_c>end_anim_dur{instance_destroy(id);exit}	//bounces back at player
					x+=lengthdir_x(dist_inc*2,end_dir)
					y+=lengthdir_y(dist_inc*2,end_dir)
					image_xscale+=scale_inc*2
					image_yscale+=scale_inc*2
					image_angle+=15*sign(x-rmw/2)*2
				break
			}
		break
	}
}

if anim=noone{
	x+=lengthdir_x(dist_inc,dir)
	y+=lengthdir_y(dist_inc,dir)

	//y+=lengthdir_y(dist_inc,dir)
	image_xscale-=scale_inc
	image_yscale-=scale_inc
	image_angle+=15*sign(x-rmw/2)
}