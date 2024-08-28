/// @description Targeting
targets = [];
allTargets = [];
fireCooldown = 60;
win = false;
total = instance_number(pixpope_lod_obj_target);

updateLockOn = function(){
  var _lockOn = (KEY_PRIMARY || KEY_SECONDARY) && !instance_exists(pixpope_lod_obj_laser);
  
  image_angle = lerp(image_angle, _lockOn ? 90 : 0, .2);
  image_yscale = image_xscale;
  image_blend = merge_color(image_blend, _lockOn ? #f45f5a : #f1f2db, .2);
  
}

aquireTargets = function(){
  ds_list_clear(list);
  var _count = instance_place_list(x, y, pixpope_lod_obj_target, list, false);
  if(!_count) return;
  
  for(var _i = 0; _i < _count; _i++){
    var _inst = list[| _i];
		if(!_inst.visible) continue;
    if(pixpope_array_find_index(targets, _inst) != -1) continue;
    addTarget(_inst);
  }
}

addTarget = function(_tar){
  if(pixpope_array_find_index(allTargets, _tar) != -1) return;
  array_push(targets, _tar);
  array_push(allTargets, _tar);
  instance_create_layer(_tar.x, _tar.y, "LockOns", pixpope_lod_obj_locked_on, {target: _tar});
}

fire = function(){
  targets = array_shuffle(targets);
  if(array_length(targets) == 0) exit;
  pixpope_array_foreach(targets, function(_x, _i){
      instance_create_depth(xstart, ystart, depth-1, pixpope_lod_obj_laser, {target: _x, delay: _i * -10});
  });

  targets = [];
}

checkWin = function(){	
	if(!visible) return;
	var _win = true
	with(pixpope_lod_obj_target){
		if(visible) _win = false;	
	}

	if(_win){
	  microgame_win()
	  if(alarm[1] == -1)
	    alarm[1] = 90;
	}	
}