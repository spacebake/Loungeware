rmw=480
rmh=320
trayw=128;		trayh=96
traystartx=32;	traystarty=32*4


trays=		[0,1,2,3,4,5]	//to contain subimg values for trays to display different foods
trays_taken=[0,0,0,0,0,0]	//to contain bools for if a tray (matching the pos of the trays[] array) is already taken by a customer
customers=[]
nowserving=0	//current customer being served

function customer_sfx_play(customer,sfx,vol,loop){	//plays new sound from customer, stops their prev sound
	if customer.sfx_playing!=noone{sfx_stop(customer.sfx_playing,0)}
	customer.sfx_playing=sfx_play(sfx,vol,loop)
}
function addcustomer(){
	if array_length(customers)>=6{exit}	//cancels addcustomer if 6 exist
	var sp=choose(orphillius_lunch_customer_sp,orphillius_lunch_customer2_sp,orphillius_lunch_customer3_sp,orphillius_lunch_customer4_sp)
	var reqtaken=true
	while reqtaken{
		var req=irandom(5)
		show_debug_message(req)
		if !trays_taken[req]{reqtaken=false}	//only passes non-taken trays
	}
	show_debug_message("took "+string(req))
	trays_taken[req]=true
	show_debug_message(trays_taken)
	var struct={
		sprite_index:	sp,
		image_index:	0,
		x:rmw+128,	y:64,		//pos for tracking customer placement during drawing
		gotox:	rmw/2,			//tracks xposition for customer to go to
		req:	req,			//chooses random food required to satisfy customer
		served:	noone,			//to hold tray value of food that has been served to customer
		anim_c:	0,				//used for tracking some animations
		sfx_playing:	noone	//used to track currently playing sound from customer
	}
	switch sp{	//getting sfx data for each customer sprite
		case orphillius_lunch_customer_sp:
			struct.sfx_hello=		orphillius_man_hello
			struct.sfx_excited=		orphillius_man_excited
			struct.sfx_yuck=		orphillius_man_yuck
			struct.sfx_happy=		orphillius_man_happy
			struct.sfx_mad=			orphillius_man_mad
		break;
		case orphillius_lunch_customer2_sp:
			struct.sfx_hello=		orphillius_larold_hello
			struct.sfx_excited=		orphillius_larold_excited
			struct.sfx_yuck=		orphillius_larold_yuck
			struct.sfx_happy=		orphillius_larold_happy
			struct.sfx_mad=			orphillius_larold_mad
		break;
		case orphillius_lunch_customer3_sp:
			struct.sfx_hello=		orphillius_frog_hello
			struct.sfx_excited=		orphillius_frog_excited
			struct.sfx_yuck=		orphillius_frog_yuck
			struct.sfx_happy=		orphillius_frog_happy
			struct.sfx_mad=			orphillius_frog_mad
		break;
		case orphillius_lunch_customer4_sp:
			struct.sfx_hello=		orphillius_tiki_hello
			struct.sfx_excited=		orphillius_tiki_excited
			struct.sfx_yuck=		orphillius_tiki_yuck
			struct.sfx_happy=		orphillius_tiki_happy
			struct.sfx_mad=			orphillius_tiki_mad
		break;
	}
	array_push(customers,struct)
	sfx_play(orphillius_bell,.3,0)
	customer_sfx_play(struct,struct.sfx_hello,1,0)
	return struct
}
var o=addcustomer()		//starts with first customer onscreen already
o.x=rmw
//creating hand struct to track movement of hand sprite
hand={	x:rmw-128,y:rmh+100,
		xspd:0,yspd:0,spdmax:20,
		accel:20,decel:.2}
hand_select_xofs=-128-16
hand_select_yofs=-136-16
hand_holding=noone
hand_anim=noone
prevtray=noone

customer_spd=3
newcustomer_timer=30