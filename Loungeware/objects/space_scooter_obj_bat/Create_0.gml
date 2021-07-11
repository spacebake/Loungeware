x = space_scooter_obj_scooter.x + random_range(-10, 50);
y = random_range(6, 16);
ystart = y;
image_index = random(image_number-1);
image_speed = 1.5;


x_diff = x - space_scooter_obj_scooter.x;

y_rad = random_range(4,6);
y_dir = random_range(0, 359);

x_rad = random_range(12, 16);
x_dir = random_range(0, 359);
x_dir_speed = random_range(0.5,2);
true_x = x;
x_offset = 0;
hsp = space_scooter_obj_scooter.hsp;

wait_timer = 0;
