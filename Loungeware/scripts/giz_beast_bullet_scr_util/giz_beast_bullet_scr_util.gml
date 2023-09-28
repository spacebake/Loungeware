function giz_beast_bullet_explode(_col=c_white, _amt=2, _x=undefined, _y=undefined, _wait=false){
	
	_x ??= x;
	_y ??= y;
	
	if ( giz.camera.shake < _amt ) giz.camera.shake = _amt*.5;	
	fx_set_parameter(giz_beast_bullet_obj_control.effect, "g_ZoomBlurCenter", [x/room_width, y/room_height]);
	
	var toWait = ( _wait ? instance_number(giz_beast_bullet_obj_explosion) : 0 );
	instance_create_depth(_x, _y, depth-1, giz_beast_bullet_obj_explosion, {
		image_blend : c_white,
		direction	: random(360),
		wait		: toWait
	});
	
	if ( !giz.math.irand(-5, 1) ) return;
	repeat(giz.math.irand(1, 3)){
		instance_create_layer(_x, _y, layer, giz_beast_bullet_obj_debris, {
			image_blend : _col,
			wait		: toWait
		});
	}
}
function giz_beast_bullet_create_tentacle(_x, _y, _dir, _col){
	var toGrow = irandom_range(3, 6);
	instance_create_layer(_x, _y, layer, giz_beast_bullet_obj_tentacle, {
		grow		: toGrow,
		grow_max	: toGrow,
		grow_dir	: irandom_range(-15, 15),
		can_fall	: false,
		direction	: _dir,
		image_blend : _col,
		parent		: undefined
	});
}
function giz_beast_bullet_get_phase() {
	return giz_beast_bullet_obj_boss.phase;
}	