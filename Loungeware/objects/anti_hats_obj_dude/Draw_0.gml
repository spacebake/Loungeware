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
if loserhat != -1 {
	var yoff = sprite_yoffset;
	var xo = sign(image_xscale) * 4;
	var hx = lengthdir_x(yoff,image_angle+90)+lengthdir_x(xo,image_angle+180); //it works ok??
	var hy = lengthdir_y(yoff,image_angle+90)+lengthdir_y(xo,image_angle+180);
	draw_sprite_ext(anti_hats_sp_hats,loserhat,x+hx,y+hy,2,2,image_angle,c_white,1);	
}


if won == 1 {
	part_particles_create(ps,random_range(-70,room_width),0,confetti,2);	
}