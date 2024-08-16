/// @description
states = {
  approach: 0,
  idle: 1,
  die: 2,
	path: 3,
}

timer = 0;
length = 75;
fireRateMin = 30;
fireRateMax = 120;
alarm[0] = irandom(fireRateMin);
if(path != noone){	
	state = states.path;
	path_start(path, 2, path_action_stop, true);
	exit;
}

var _arr = array_shuffle(animcurve_get(pixpope_lod_ac_approach).channels);
horiCurve = _arr[0];
_arr = array_shuffle(_arr);
vertCurve = _arr[0];

var _dir = point_direction(room_width/2, room_height/2, x, y);
entryPoints = {
  start: [x + lengthdir_x(room_width, _dir), y + lengthdir_y(room_height, _dir)],
  finish: [xstart, ystart]
}
x = entryPoints.start[0];
y = entryPoints.start[1];


state = states.approach;