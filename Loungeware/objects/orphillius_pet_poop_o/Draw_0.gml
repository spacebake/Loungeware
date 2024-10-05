draw_self()

switch anim{
	case 1:
		switch anim_phase{
			case 0:	//mop init
				mop={
					x: x-sign(x-rmw/2)*16,
					y: -8,
					image_index: 0
				}
				anim_phase+=1
			break
			case 1:	//mop comes down
				mop.y+=16
				if mop.y>=game.floory+32{
					anim_phase+=1
					sfx_play(orphillius_sfx_item_flyaway,gain)
				}
			break
			case 2:	//mop to the side
				var dir=sign(x-rmw/2)
				if dir=1{mop.image_index=1}else{mop.image_index=2}
				mop.x+=dir*12
				x+=dir*12
				if mop.x>rmw+8 or mop.x<-8{
					instance_destroy(id)
				}
			break
			//mop sweeps poop off side of screen
			//poop destroyed
		}
	break
}

if mop!=noone{
	var scale=game.drawscale
	draw_sprite_ext(orphillius_pet_mop_s,mop.image_index,mop.x,mop.y,scale,scale,0,c_white,1)
}