image_index = irandom_range(0, sprite_get_number(sprite_index)-1);
image_alpha = 0.2;
image_xscale = 0.5;
image_yscale = 0.5;
x = choose(-sprite_width, room_width+sprite_width);
dir = (x == -sprite_width) ? 1 : -1;
spd = random_range(0.5, 1.5);
