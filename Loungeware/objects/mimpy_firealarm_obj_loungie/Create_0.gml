dir = choose(-1, 1);
spd = 1;
if (DIFFICULTY > 3)
	spd += (DIFFICULTY - 3) * 1.5;

time_offset = random(1000);

burning = true;

image_speed = 0;

lifetime = irandom(5);