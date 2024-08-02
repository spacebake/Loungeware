/// @description
var _col = make_color_hsv(irandom(255), 255, irandom_range(128,255))

image_blend = _col;
image_xscale = random_range(.5, 1.5);
image_yscale = random_range(.75, 1.25) * choose(-1, 1);
image_angle = random(360);
life = 15;