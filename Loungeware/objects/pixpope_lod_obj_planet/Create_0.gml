x = random_range(room_width/2, room_width)
hspeed = -random_range(.15,.25);
y = random_range(-room_height * .5, room_height * 1.5);
image_blend = merge_color(c_white, #07232c, .5);
image_angle = random(360);
image_index = irandom(image_number - 1);
