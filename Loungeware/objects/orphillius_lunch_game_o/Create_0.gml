rmw=480
rmh=320

trays=[0,1,2,3,4,5]	//to contain subimg values for trays to display different foods
array_shuffle(trays)

customers=[]
nowserving=0	//current customer being served

function addcustomer(){
	var struct={
		sprite_index:	orphillius_lunch_customer_sp,
		image_index:	0,
		x:rmw+128,	y:64,	//pos for tracking customer placement during drawing
		gotox:	rmw/2,		//tracks xposition for customer to go to
		req:	irandom(5),	//chooses random food required to satisfy customer
		served:	noone,		//to hold tray value of food that has been served to customer
		anim_c:	0			//used for tracking some animations
	}
	array_push(customers,struct)
	return struct
}
var o=addcustomer()		//starts with first customer onscreen already
o.x=rmw
addcustomer()
//creating hand struct to track movement of hand sprite
hand={	x:rmw-128,y:rmh+100,
		xspd:0,yspd:0,spdmax:13,
		accel:1.5,decel:.6}
hand_select_xofs=-128-16
hand_select_yofs=-136-16
hand_holding=noone
hand_anim=noone
