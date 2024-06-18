var keypress=(KEY_PRIMARY)//_PRESSED)


draw_sprite(orphillius_lunch_table_sp,1,0,0)	//bg color sprite

////drawing customers
for (var c=0;c<array_length(customers);c++){
	var anim_shake=false
	var o=customers[c]
	if o.served!=noone{
		
	}
	if abs(o.x-o.gotox)>4{		//moving customer towards gotox
		if c=0 or (c>0 and point_distance(o.x,0,customers[c-1].x,0)>96){
			o.x+=3*sign(o.gotox-o.x)
			anim_shake=true
		}
	}
	if o.image_index=1{anim_shake=true}
	if anim_shake{o.anim_c+=1;if o.anim_c=5{o.y+=4};if o.anim_c=10{o.y-=4;o.anim_c=0}}
	draw_sprite(o.sprite_index,o.image_index,o.x,o.y)
}

////drawing food trays, also does collision check
var xx=32;var yy=32*4
var xofs=0
var trayw=128;var trayh=96
var intray=noone	//to contain trays[] position of selected tray
for (var trayc=0;trayc<array_length(trays);trayc++){
	draw_sprite(orphillius_lunch_tray_sp,trays[trayc],xx,yy)
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
	if c=nowserving and o.served=noone{						//changes expression of first customer to show what they want
		if intray=o.req{o.image_index=1}	//correct choice
		else{o.image_index=2}				//incorrect
	}
	draw_sprite(o.sprite_index,5,o.x,o.y)
	if o.served!=noone{draw_sprite(orphillius_lunch_food_sp,o.served,o.x-trayw/2,o.y-trayh/2)}
}

if keypress and intray!=noone and hand_holding=noone{hand_holding=intray}	//sets hand_holding to pressed tray
if hand_holding!=noone{		//draws hand holding item from tray, animates it going to the customer
	draw_sprite(orphillius_lunch_hand_sp,1,hand.x,hand.y)
	draw_sprite(orphillius_lunch_food_sp,trays[hand_holding],hand.x+hand_select_xofs-trayw/2,hand.y+hand_select_yofs-trayh/2-24)
	draw_sprite(orphillius_lunch_hand_sp,2,hand.x,hand.y)
	hand_anim="serve"
}else{draw_sprite(orphillius_lunch_hand_sp,0,hand.x,hand.y)}	//otherwise draws regular hand subimg
