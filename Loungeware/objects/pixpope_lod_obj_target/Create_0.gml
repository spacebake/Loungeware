/// @description
states = {
  approach: 0,
  idle: 1,
  die: 2,
	path: 3,
	loopCenter: 4,
}

timer = -pathDelay;
length = 75;
fireRateMin = 30;
fireRateMax = 120;
alarm[0] = irandom(fireRateMin);
switch(image_index){
	case 0: lockOffset = -9; break;
	case 1: lockOffset = -2; break;
	case 2: lockOffset = 8; break;
	case 3: lockOffset = 4; break;
}


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
	state = states.idle;
	switch(endPathBehavior){
		case "Loop Center": 
			state = states.loopCenter;
			
			loop.updateStart(x, y);
			loop.update();
		break;
	}
}
entryPoints = {start: [0,0], finish: [0,0]}
state = states.approach;
if(path != noone){
	if(path_is_absolute){
		state = states.path;
		exit;
	} else {
		horiCurve = animcurve_get_channel(pixpope_lod_ac_approach, "expo");
		vertCurve = animcurve_get_channel(pixpope_lod_ac_approach, "expo");
		
		entryPoints.start = [x, y];
		var _endX = x + path_get_point_x(path, 1) - path_get_point_x(path, 0);
		var _endY = y + path_get_point_y(path, 1) - path_get_point_y(path, 0);
		entryPoints.finish = [_endX, _endY]
		
		exit;
	}
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



