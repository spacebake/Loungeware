var xinp=KEY_RIGHT-KEY_LEFT
var yinp=KEY_DOWN-KEY_UP
var anim=hand_anim
with hand{	//applying input to hand
	var rmw=480;var rmh=320
	if anim=noone{
		xspd=clamp(xspd+xinp*accel,-spdmax,spdmax)
		if xinp=0{xspd=lerp(xspd,0,decel)}
		yspd=clamp(yspd+yinp*accel,-spdmax,spdmax)
		if yinp=0{yspd=lerp(yspd,0,decel)}
		
		if x+xspd>rmw+150 or x+xspd<150{xspd*=-.8}	//bounces within range of play area
		x+=xspd
		if y+yspd>rmh+200 or y+yspd<200{yspd*=-.8}
		y+=yspd
		
		if xinp=0 and yinp=0{		//lerping hand to center of nearest tray				/////!!!!!!!!!!!!WORK ON THIS! trying to make hand snap between trays. probably should rewrite movement code for it to work well
			var tw=orphillius_lunch_game_o.trayw;	var th=orphillius_lunch_game_o.trayh
			var tx=clamp(round(x/tw),2,4)*tw
			var ty=clamp(round(y/th),3,4)*th+th/2
			//show_debug_message(string(round(x/tw))+","+string(round(y/th)))
			x=clamp(lerp(x,tx,.3),0,room_width);	y=clamp(lerp(y,ty,.3),50,room_height+100)
		}
		x=clamp(x,0,room_width);	y=clamp(y,0,room_height+100)
	}
	else{
		if anim="serve"{
			x=lerp(x,380,.2)
			y=lerp(y,270,.2)
			if point_distance(x,y,380,270)<4 with orphillius_lunch_game_o{
				sfx_play(orphillius_food_drop,1,0)
				var o=customers[nowserving]
				o.served=hand_holding
				if o.served=o.req{	//correct food served!
					o.image_index=3	
					o.gotox=-999
					customer_sfx_play(o,o.sfx_happy,1,0)
					if nowserving+1>=array_length(customers){	//all customers served correctly! WIN!!
						microgame_win()
						sfx_play(orphillius_win,1,0)
					}else{
						nowserving+=1		//sets nowserving to next customer if there is one
					}
				}
				else{			//incorrect food served. LOSE!
					o.image_index=4
					sfx_play(orphillius_fail,.4,0)
					customer_sfx_play(o,o.sfx_mad,1,0)
					var now=nowserving+1
					while now<array_length(customers){
						var o=customers[now]
						o.image_index=4
						customer_sfx_play(o,o.sfx_mad,1,0)
						now+=1
					}
				}
				
				hand_holding=noone
				hand_anim="return"
			}
		}
		if anim="return"{
			x=lerp(x,rmw-128,.2)
			y=lerp(y,rmh+100,.2)
			if point_distance(x,y,rmw-128,rmh+100)<4{
				orphillius_lunch_game_o.hand_anim=noone
			}
		}
	}
}

//if KEY_SECONDARY_PRESSED{addcustomer()} /////DEBUG