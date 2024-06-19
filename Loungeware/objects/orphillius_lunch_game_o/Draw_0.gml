var keypress=(KEY_PRIMARY_PRESSED)

newcustomer_timer-=1
if newcustomer_timer=0{
	var customercount=1
	switch DIFFICULTY{		//finds how many customers to spawn per difficulty
		case 1: customercount=2;break
		case 2: customercount=3;break
		case 3: customercount=3;break
		case 4: customercount=4;break
		case 5: customercount=4;break
	}
	if array_length(customers)<customercount{
		addcustomer()
	}
	newcustomer_timer=120
}

draw_sprite(orphillius_lunch_table_sp,1,0,0)	//bg color sprite

////drawing customers, moving them to their gotox, animating shake up/down
for (var c=0;c<array_length(customers);c++){
	var anim_shake=false
	var o=customers[c]
	if abs(o.x-o.gotox)>4{		//moving customer towards gotox
		if c=0 or (c>0 and point_distance(o.x,0,customers[c-1].x,0)>96){
			o.x+=customer_spd*sign(o.gotox-o.x)
			anim_shake=true
		}
	}
	if o.image_index=1 or o.image_index=4{anim_shake=true}
	if anim_shake{o.anim_c+=1;if o.anim_c=5{o.y+=4};if o.anim_c=10{o.y-=4;o.anim_c=0}}
	draw_sprite(o.sprite_index,o.image_index,o.x,o.y)
	//draw_text(o.x,o.y,o.req)	//DEBUG
}

draw_sprite(orphillius_lunch_table_sp,2,0,0)	//empty trays sprite

////drawing food trays, also does collision check
var xx=traystartx;var yy=traystarty
var xofs=0
var intray=noone	//to contain trays[] position of selected tray
for (var trayc=0;trayc<array_length(trays);trayc++){
	if trays[trayc]!=noone{draw_sprite(orphillius_lunch_tray_sp,trays[trayc],xx,yy)}
	//draw_sprite(orphillius_lunch_food_sp,trays[trayc],xx,yy)

	//draw_rectangle(	hand.x+hand_select_xofs,	hand.y+hand_select_yofs,
	//				hand.x+hand_select_xofs-16,	hand.y+hand_select_yofs-16,1)
	//draw_rectangle(
	//				xx,			yy,
	//							xx+trayw,	yy+trayh,1
	//				)
	if hand_holding=noone and rectangle_in_rectangle(	hand.x+hand_select_xofs,	hand.y+hand_select_yofs,
								hand.x+hand_select_xofs-16,	hand.y+hand_select_yofs-16,
								xx,			yy,
								xx+trayw,	yy+trayh
								)
	{
		intray=trayc
	}
	xx+=trayw; xofs+=1; if xofs>2{xofs=0;xx=32;yy+=trayh}
}

draw_sprite(orphillius_lunch_table_sp,0,0,0)	//draws table overlay

//drawing customer's tray sprites over the table. adjusts the customer's sprites depending on currently hovered tray
for (var c=0;c<array_length(customers);c++){
	var anim_shake=false
	var o=customers[c]
	if c=nowserving and o.served=noone and hand_anim=noone and o.x<rmw*.8{						//changes expression of first customer to show what they want
		if intray=o.req{		//hovering correct tray
			o.image_index=1
			if prevtray!=intray{customer_sfx_play(o,o.sfx_excited,1,0)}
		}
		else{					//hovering correct tray
			o.image_index=2
			if prevtray!=intray{customer_sfx_play(o,o.sfx_yuck,1,0)}
		}
	}
	draw_sprite(o.sprite_index,5,o.x,o.y)
	if o.served!=noone{draw_sprite(orphillius_lunch_food_sp,o.served,o.x-trayw/2,o.y-trayh/4)}
}

if keypress and intray!=noone and hand_holding=noone and customers[nowserving].served=noone{	//sets hand_holding to pressed tray
	hand_holding=intray
	trays[intray]=noone
	sfx_play(orphillius_food_grab,1,0)
}
if hand_holding!=noone{		//draws hand holding item from tray, animates it going to the customer
	draw_sprite(orphillius_lunch_hand_sp,1,hand.x,hand.y)
	draw_sprite(orphillius_lunch_food_sp,hand_holding,hand.x+hand_select_xofs-trayw/2,hand.y+hand_select_yofs-trayh/2-24)
	draw_sprite(orphillius_lunch_hand_sp,2,hand.x,hand.y)
	hand_anim="serve"
}else{draw_sprite(orphillius_lunch_hand_sp,0,hand.x,hand.y)}	//otherwise draws regular hand subimg

prevtray=intray