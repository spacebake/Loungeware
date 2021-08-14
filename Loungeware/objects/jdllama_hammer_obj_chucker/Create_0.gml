image_angle = irandom_range(0, 180);
myDebug = false;
_step = function() {
	image_angle += 6 + DIFFICULTY;
	if(image_angle > 360) image_angle -= 360;
	if(myDebug == true) {
		image_angle = point_direction(x,y,mouse_x,mouse_y);
	}
}