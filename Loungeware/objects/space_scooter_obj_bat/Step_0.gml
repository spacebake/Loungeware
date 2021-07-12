x = true_x + x_offset;
true_x += hsp;

y = ystart + lengthdir_y(y_rad, y_dir);
y_dir += 2;

x_offset = lengthdir_x(x_rad, x_dir);
x_dir += x_dir_speed

if (wait_timer && image_index + image_speed >= image_number-1){
	image_index = image_number;
	if (wait_timer <= 0){
		wait_timer = random_range(2, 50);
		image_index = 0;
	}
	wait_timer--;
}


