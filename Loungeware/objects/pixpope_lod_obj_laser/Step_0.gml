timer++;
if(timer < 0) exit;

var _prevPos = animcurve_channel_evaluate(curve, timer / length);
if(instance_exists(target))
	path_change_point(myPath, 2, target.x, target.y, 0);

if(timer == length){
	call_later(pixpope_lod_obj_trail.life, time_source_units_frames, function(){instance_destroy()});
	instance_destroy(target);
	exit;
}

if(timer >= length) exit;

var _pos = animcurve_channel_evaluate(curve, (min(timer+1, length)) / length);
while(_prevPos < _pos){
	_prevPos += .01;
	var _newX = path_get_x(myPath, _prevPos)
	var _newY = path_get_y(myPath, _prevPos);
	array_push(myTrail,instance_create_depth(_newX,_newY,depth,pixpope_lod_obj_trail, {owner: myTrail}));
}