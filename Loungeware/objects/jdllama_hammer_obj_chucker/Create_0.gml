image_angle = irandom_range(0, 180);
myDebug = false;
image_index = 0;
image_speed = 0;
spinMe = true;
_step = function() {
	if(spinMe == true) image_angle += 6 + DIFFICULTY;
	if(image_angle > 360) image_angle -= 360;
	if(myDebug == true) {
		image_angle = point_direction(x,y,mouse_x,mouse_y);
	}
}

_alarm0 = function() {
	if(spinMe == true) {
		alarm[0] = 35;
		sfx_play(jdllama_hammer_snd_whoosh,1.2,false);
	}
	
}

alarm[0] = 35;