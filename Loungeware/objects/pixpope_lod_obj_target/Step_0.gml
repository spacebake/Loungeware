/// @description
switch(state){
	case states.path:
		if(timer >= 0 && path_position == 0){
			path_start(path, pathSpeed, path_action_stop, path_is_absolute);
		}
		if(path_position >= pathMaxPosition){
			path_end();
			onPathEnd();
		}
	break;
  case states.approach: 
    x = lerp(entryPoints.start[0], entryPoints.finish[0], animcurve_channel_evaluate(horiCurve, timer/length));
    y = lerp(entryPoints.start[1], entryPoints.finish[1], animcurve_channel_evaluate(vertCurve, timer/length));
    if(timer >= length) state = states.idle;
  break;
	case states.loopCenter:
		loop.update();
	break;
}
timer++;
if(timer mod 2 == 0) {
	instance_create_depth(x, y, depth+1, pixpope_lod_obj_afterimage, {
		sprite_index: sprite_index,
		image_index: image_index,
		image_angle: image_angle,
	})
}