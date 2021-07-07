//var dir = (KEY_RIGHT || KEY_LEFT || KEY_UP || KEY_DOWN) 
//	? point_direction(0, 0, KEY_RIGHT - KEY_LEFT, KEY_UP - KEY_LEFT)
//	: undefined;
var x_dir = KEY_RIGHT_PRESSED - KEY_LEFT_PRESSED;
var y_dir = KEY_DOWN_PRESSED - KEY_UP_PRESSED;

cursor.x += x_dir;
cursor.y += y_dir;

if (any_dir_key()) {
	cursor.t = 0;
	cursor.drawing = true;
}
cursor.t++;

if ((cursor.t % cursor.flash_delay) == 0)
	cursor.drawing = !cursor.drawing;

