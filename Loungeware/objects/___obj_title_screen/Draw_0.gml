// draw logo
var _logo_x = WINDOW_BASE_SIZE/2;
var _logo_y = WINDOW_BASE_SIZE/2;
var _spr = ___spr_logo_title;
var _frame = 0;
var _pump_scale = 1.2;
var _pump_speed = 15;
draw_sprite_ext(_spr, _frame, _logo_x, _logo_y, logo_scale, logo_scale, 0, c_white, logo_scale);



if (substate == 0){
	logo_scale = abs(lengthdir_y(_pump_scale, logo_scale_dir));
	if (logo_scale_dir > 90 && logo_scale <= 1){
		substate++;
		logo_scale = 1;
		logo_scale_dir = 180;
	}
	logo_scale_dir += _pump_speed;
}

if (substate == 1){
	var _pump_speed = 20;
	if (trigger_pump){
		logo_scale_dir = 0; 
		trigger_pump = false;
	}
	_pump_scale = 1.05;
	var _extra_scale = abs(lengthdir_y(_pump_scale-1, logo_scale_dir));
	logo_scale = 1 + _extra_scale;
	logo_scale_dir = min(180, logo_scale_dir + _pump_speed);
	
	
}


ribbon_hide_prog = ___smooth_move(ribbon_hide_prog, 0, 0.01, 6);



// label anim
var _label_y = ((WINDOW_BASE_SIZE - label_h) - label_sep);
var _this_x, _prog, _dir, _rad, _yy;

_rad = 0;
	draw_set_color(c_gbyellow);
	//draw_rectangle_fix(0, 0, WINDOW_BASE_SIZE, label_h + (label_sep*2));
	//draw_rectangle_fix(0, WINDOW_BASE_SIZE - (label_h + (label_sep*2)), WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);

for (var i = 0; i < ds_list_size(label_list); i++){
	
	_this_x = label_x + (i*(label_w  + label_sep));
	_prog = clamp(_this_x + (label_w/2), 0, WINDOW_BASE_SIZE)/WINDOW_BASE_SIZE;
	_dir = _prog * 540;
	_yy = _label_y;
	var _y_hide_offset = ribbon_hide_prog * label_h;
	
	
	if (_this_x + label_w >= 0  && _this_x < WINDOW_BASE_SIZE) {
		draw_sprite_stretched(label_list[| i], 0, _this_x, _yy + _y_hide_offset, label_w, label_h);
		draw_sprite_stretched(label_list_2[| i], 0,  -_this_x + (WINDOW_BASE_SIZE - label_w), (_yy - (WINDOW_BASE_SIZE - (72))) - _y_hide_offset, label_w, label_h);
	}
	
	_this_x -= label_w_total;
	_prog = clamp(_this_x + (label_w/2), 0, WINDOW_BASE_SIZE)/WINDOW_BASE_SIZE;
	_dir = _prog * 720;
	_yy = _label_y + lengthdir_y(_rad, _dir);
	
	if (_this_x + label_w >= 0 && _this_x < WINDOW_BASE_SIZE) {
		draw_sprite_stretched(label_list[| i], 0, _this_x, _yy + _y_hide_offset, label_w, label_h);
		draw_sprite_stretched(label_list_2[| i], 0, -_this_x +  (WINDOW_BASE_SIZE - label_w), (_yy - (WINDOW_BASE_SIZE - (72))) - _y_hide_offset, label_w, label_h);
	}
	
}


if (state == "close"){
	
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(circle_surf)){
		circle_surf = surface_create(_size, _size);
	}

	surface_set_target(circle_surf);
	draw_clear(c_gbdark);
	gpu_set_blendmode(bm_subtract);
	var _rad = close_circle_prog * (_size/2);
	draw_circle(_size/2, (_size/2)/*-30*/, close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_surface_stretched(circle_surf, 0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	close_circle_prog = max(0, close_circle_prog - (1/30));
	//close_circle_prog = ___smooth_move(close_circle_prog, 0, 0.025, 10);
	if (close_circle_prog <= 0) close_wait--;
	if (close_wait <= 0){
		instance_create_layer(0, 0, layer, ___obj_main_menu);
		instance_destroy();
	}


}

