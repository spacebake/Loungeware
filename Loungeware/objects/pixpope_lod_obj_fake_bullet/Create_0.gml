/// @description Insert description here
// You can write your code in this editor
direction = point_direction(x, y, pixpope_lod_obj_reticle.xstart, pixpope_lod_obj_reticle.ystart);
direction += choose(5, 6, 7.5, 9, 10) * choose(1, -1);
image_angle = direction;
var _minSpeed = 7;
var _maxSpeed = 10;
speed = random_range(_minSpeed, _maxSpeed);
image_xscale = lerp(2, 4, (speed-_minSpeed) / (_maxSpeed-_minSpeed))

color = make_color_hsv(irandom_range(18, 32), 128, 255);
timer = 0;



