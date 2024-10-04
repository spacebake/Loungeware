////SUCCESS!
if successes>=success_req and !MICROGAME_WON{
	microgame_win()
	pet.sprite_index=choose(orphillius_pet_adult_s,orphillius_pet_adult2_s,orphillius_pet_adult3_s)
	request=noone
	if instance_exists(orphillius_pet_poop_o) with orphillius_pet_poop_o{anim=1}
	var dir=0
	var scale=drawscale
	repeat(15){
		with instance_create_depth(pet.x,pet.y-8,pet.depth-25,orphillius_pet_egg_o){
			sprite_index=orphillius_pet_smoke_s
			image_angle=irandom(360)
			direction=dir
			speed=8
			friction=.4
			image_xscale=scale;	image_yscale=scale
			dir+=360/15
		}
	}
	sfx_play(orphillius_sfx_fwooh,gain)
	//sfx_play(orphillius_win,gain)
}
if MICROGAME_WON{
	with orphillius_pet_egg_o{	//makes smoke bits spin and disappear
		image_angle-=6
		image_xscale-=.07
		image_yscale-=.07
		if image_xscale<=.1{instance_destroy(id)}
	}
	postwin_c+=1	//counter to delay adult sfx
	if postwin_c=10{
		switch pet.sprite_index{
			case orphillius_pet_adult_s: var sfx=orphillius_sfx_adult1;break
			case orphillius_pet_adult2_s: var sfx=orphillius_sfx_adult2;break
			case orphillius_pet_adult3_s: var sfx=orphillius_sfx_adult3;break
		}
		sfx_play(sfx,gain*1.2)
	}
	exit
}

switch game_phase{
	case 0:	//spawn egg, init menu
		egg=instance_create_depth(rmw/2,0,0,orphillius_pet_egg_o)
		egg.yspd=2
		egg.image_xscale=drawscale;		egg.image_yscale=drawscale
		sfx_play(orphillius_sfx_item_throw,gain)
		game_phase+=1
	break;
	case 1:	//eggs falls and explodes, create baby
		egg.yspd+=.5
		egg.y+=egg.yspd
		if egg.y>=floory{
			sfx_play(orphillius_sfx_egg_crack,gain)
			////creates egg shell bits that go flying away
			egg.image_index=1
			var shell=instance_create_depth(egg.x,egg.y,egg.depth+5,orphillius_pet_egg_o)
			shell.image_index=2
			repeat(6){
				shell=instance_create_depth(egg.x,egg.y,egg.depth+10,orphillius_pet_egg_o)
				shell.image_index=irandom_range(3,6)
			}
			var scale=drawscale
			with orphillius_pet_egg_o{	//sets all egg pieces to go flying away
					image_xscale=scale
					image_yscale=scale
					direction=choose(irandom_range(15,45),irandom_range(120,135))
					speed=irandom_range(8,10)
					gravity=.1
			}
			////creates baby
			pet=instance_create_depth(egg.x,floory,egg.depth+10,orphillius_pet_pet_o)
			pet.image_xscale=drawscale
			pet.image_yscale=drawscale
			game_phase+=1
		}
	break;
	case 2:	//pet makes requests and creates poop
		action_c+=1
		if action_c>=action_timer{
			pet.sprite_index=orphillius_pet_baby_s
			action_c=0
			choices=[]
			if request=noone{
				array_push(choices,"request","request")
			}
			if !instance_exists(orphillius_pet_poop_o) and poops_pooped<poops_possible{array_push(choices,"poop")}
			var choice=noone
			if array_length(choices)>0{choice=choices[irandom(array_length(choices)-1)]}
			switch choice{
				case "request":
					request=choose(orphillius_pet_play_s,orphillius_pet_food_s)
					sfx_play(orphillius_sfx_request_appears,gain)
				break
				case "poop":
					with instance_create_depth(pet.x,pet.y,pet.depth+5,orphillius_pet_poop_o){
						image_xscale=orphillius_pet_game_o.drawscale; image_yscale=orphillius_pet_game_o.drawscale
						direction=choose(0,180)
						speed=irandom_range(6,8)
						friction=.2
					}
					poops_pooped+=1
					sfx_play(orphillius_sfx_poop,gain)
				break
			}
		}
		
	break;
}

with orphillius_pet_egg_o if image_index!=0{	//destroying egg bits
	if y>orphillius_pet_game_o.rmh+64{
		instance_destroy(id)
	}
	var mdir=point_direction(0,0,lengthdir_x(speed,direction),lengthdir_y(speed,direction))
	if mdir<90 or mdir>270{image_angle-=6}else{image_angle+=6}
}

////controls
//menu scroll
if KEY_DOWN_PRESSED{
	menu_current+=1;	if menu_current>=array_length(menu_options){menu_current=0}
	sfx_play(orphillius_sfx_menu_blip,gain)
}
if KEY_UP_PRESSED{
	menu_current-=1;		if menu_current<0{menu_current=array_length(menu_options)-1}
	sfx_play(orphillius_sfx_menu_blip,gain)
}
//menu select
if instance_exists(pet) and (KEY_PRIMARY_PRESSED or KEY_SECONDARY_PRESSED){
	sfx_play(orphillius_sfx_menu_blip2,gain)
	switch menu_options[menu_current]{
		case "Feed":
			if request!=noone and !instance_exists(orphillius_pet_item_o){
				with instance_create_depth(0,0,-100,orphillius_pet_item_o){sprite_index=orphillius_pet_food_s}
				sfx_play(orphillius_sfx_item_throw,gain)
				action_c=0
				if request=orphillius_pet_food_s{	//correct request chosen
					successes+=1
					pet.sprite_index=orphillius_pet_baby_eat_s
					pet.image_index=0
				}else{
					pet.sprite_index=orphillius_pet_baby_sad_s
				}
			}
		break
		case "Clean":
			if instance_exists(orphillius_pet_poop_o) and orphillius_pet_poop_o.anim=noone{	//cleaning poop
				orphillius_pet_poop_o.anim=1
				successes+=1
				action_c=0
			}
		break
		case "Play":
			if request!=noone and !instance_exists(orphillius_pet_item_o){
				with instance_create_depth(0,0,-100,orphillius_pet_item_o){sprite_index=orphillius_pet_play_s}
				sfx_play(orphillius_sfx_item_throw,gain)
				action_c=0
				if request=orphillius_pet_play_s{	//correct request chosen
					successes+=1
					pet.sprite_index=orphillius_pet_baby_play_s
					pet.image_index=0
				}else{
					pet.sprite_index=orphillius_pet_baby_sad_s
				}
			}
		break
	}
}
////
//counter for draw_sprite subimages
anim_c+=3/60
if anim_c>600{anim_c=0}
