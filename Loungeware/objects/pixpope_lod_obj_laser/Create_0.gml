/// @description Insert description here
// You can write your code in this editor
myPath = path_add();
path_set_kind(myPath, true);
path_set_closed(myPath, false);

path_add_point(myPath,x,y,0);

var _dist = random_range(90, 120);
var _angle = random_range(135, 215);

path_add_point(myPath,
							 x + lengthdir_x(_dist, _angle),
							 y + lengthdir_y(_dist, _angle),
							 0);
							 
path_add_point(myPath, target.x, target.y,0);
timer=delay;
length = 30;

curve = animcurve_get_channel(pixpope_lod_ac_generic, "cubicIn");

surf = noone;
myTrail = [];