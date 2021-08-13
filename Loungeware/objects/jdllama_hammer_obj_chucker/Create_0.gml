image_angle = irandom_range(0, 180);
myDebug = true;
_step = function() {
	image_angle += 5;
	if(myDebug == true) {
		image_angle = point_direction(x,y,mouse_x,mouse_y);
	}
}