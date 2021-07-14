/// @description move




//move
var hpress = (-KEY_LEFT_PRESSED + KEY_RIGHT_PRESSED);
targ = clamp(targ+hpress*hatspace,hatspace,room_width-hatspace);


var prev = x;
x = lerp(x,targ,.3);
image_angle = -(prev-x)*2;

flip = image_angle==0 ? flip : sign(image_angle);
image_xscale = flip*2;
draw_self();


if won == 1 {
	part_particles_create(ps,random_range(-70,room_width),0,confetti,2);	
}