/// @description
states = {
  approach: 0,
  idle: 1,
  die: 2,
	path: 3,
	loopCenter: 4,
}

timer = 0;
length = 75;
fireRateMin = 30;
fireRateMax = 120;
alarm[0] = irandom(fireRateMin);

loop = {
	owner: id,
	dist: 0,
	targetX: loopX,
	targetY: loopY,
	curAngle: 0,
	speed: loopSpeed,
	updateStart: function(){
		curAngle = point_direction(targetX, targetY, owner.x, owner.y);
		dist = point_distance(targetX, targetY, owner.x, owner.y);
	},
	update: function() {
		curAngle += speed;
		owner.x = targetX + lengthdir_x(dist, curAngle);
		owner.y = targetY + lengthdir_y(dist, curAngle);
	}
}

onPathEnd = function(){	
	switch(endPathBehavior){
		case "Loop Center": 
			state = states.loopCenter;
			loop.updateStart(x, y);
		break;
	}
}

if(path != noone){	
	state = states.path;
	if(pathDelay > 0) {
		call_later(pathDelay, time_source_units_frames, function(){
			path_start(path, pathSpeed, path_action_stop, true);
		})
		exit;
	}
	path_start(path, pathSpeed, path_action_stop, true);
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

