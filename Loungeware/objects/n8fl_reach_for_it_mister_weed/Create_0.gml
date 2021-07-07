spd = -random_range(2,2.5) * 0.5;
tumble_speed = 1.5 * -spd;
image_speed = 0;

start_x = x;
start_y = y;
offset_x = 0;
hop_offset = 0;
hop_speed = 50 * tumble_speed * -spd;
hop_force = 4;

r = random(360);
image_angle += r;