// Controls
if (KEY_RIGHT) {
	direction -= spin_speed;	
}

if (KEY_LEFT) {
	direction += spin_speed;	
}

image_index = (direction + 45) div 90;
