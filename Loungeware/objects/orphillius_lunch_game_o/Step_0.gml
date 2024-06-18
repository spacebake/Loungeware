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
	
		if x+xspd>rmw+50 or x+xspd<150{xspd*=-1}	//bounces within range of play area
		x+=xspd
		if y+yspd>rmh+150 or y+yspd<200{yspd*=-1}
		y+=yspd
	}
	else{
		if anim="serve"{
			x=lerp(x,380,.2)
			y=lerp(y,270,.2)
			if point_distance(x,y,380,270)<4 with orphillius_lunch_game_o{
				var o=customers[nowserving]
				o.served=hand_holding
				if o.served=o.req{	//correct food served!
					o.image_index=3	
					o.gotox=-128
					if nowserving+1>=array_length(customers){
						microgame_win()
					}else{
						nowserving+=1
					}
				}
				else{
					o.image_index=4
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

if KEY_SECONDARY_PRESSED{addcustomer()}