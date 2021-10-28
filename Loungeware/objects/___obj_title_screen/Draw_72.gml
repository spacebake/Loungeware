if (bg_alpha > 0){
	
	if (!surface_exists(bg_shd_surf)){
		bg_shd_surf = surface_create(WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	}
	
	var _draw_y = bg_y + bg_y2;
	
	draw_set_alpha(bg_alpha);
	draw_sprite(___spr_title_bg, 1, bg_x, _draw_y);
	draw_sprite(___spr_title_bg, 1, bg_x, _draw_y - VIEW_H);
	draw_sprite(___spr_title_bg, 1, bg_x, _draw_y - (VIEW_H*2));
	
	draw_sprite(___spr_title_bg, 1, bg_x-VIEW_W, _draw_y );
	draw_sprite(___spr_title_bg, 1, bg_x-VIEW_W, _draw_y - VIEW_H );
	draw_sprite(___spr_title_bg, 1, bg_x-VIEW_W, _draw_y - (VIEW_H*2) );
	draw_set_alpha(1);
	
	surface_set_target(bg_shd_surf);
	draw_clear_alpha(c_white, 0);
	
	
	draw_sprite(___spr_title_bg, bg_frame, bg_x, _draw_y);
	draw_sprite(___spr_title_bg, bg_frame, bg_x, _draw_y - VIEW_H);
	draw_sprite(___spr_title_bg, bg_frame, bg_x, _draw_y - (VIEW_H*2));
	
	draw_sprite(___spr_title_bg, bg_frame, bg_x-VIEW_W, _draw_y );
	draw_sprite(___spr_title_bg, bg_frame, bg_x-VIEW_W, _draw_y - VIEW_H );
	draw_sprite(___spr_title_bg, bg_frame, bg_x-VIEW_W, _draw_y - (VIEW_H*2) );

	
	gpu_set_blendmode(bm_subtract);
	var _rad = bg_circle_rad  + lengthdir_y(10, next_beat_prog * 180);
	var _circle_scale = ((_rad*2) / sprite_get_width(___spr_circle_64));
	draw_sprite_ext(___spr_circle_64, 0, WINDOW_BASE_SIZE/2, WINDOW_BASE_SIZE/2, _circle_scale, _circle_scale, 0, c_white, 1);
	gpu_set_blendmode(bm_normal);

	
	surface_reset_target();
	draw_set_alpha(bg_alpha);
	draw_surface_stretched(bg_shd_surf, 0, 0, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
	draw_set_alpha(1);

	bg_x += bg_speed;
	bg_y += bg_speed;
	bg_y2 += bg_speed/2;
	if (bg_y2 >= VIEW_H) bg_y2 -= VIEW_H;
	if (bg_x >= VIEW_W){
		bg_x -= VIEW_W;
		bg_y -= VIEW_W;
	}

	
}



// label anim
var _label_y = ((WINDOW_BASE_SIZE - label_h));
var _this_x, _prog, _dir, _rad, _yy;
var _vgap = 0;
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
		draw_sprite_stretched(label_list[| i], 0, _this_x, (_yy + _y_hide_offset) - _vgap, label_w, label_h);
		draw_sprite_stretched(label_list_2[| i], 0,  -_this_x + (WINDOW_BASE_SIZE - label_w), ((_yy - (WINDOW_BASE_SIZE - (72))) - _y_hide_offset) + _vgap, label_w, label_h);
	}
	
	_this_x -= label_w_total;
	_prog = clamp(_this_x + (label_w/2), 0, WINDOW_BASE_SIZE)/WINDOW_BASE_SIZE;
	_dir = _prog * 720;
	_yy = _label_y + lengthdir_y(_rad, _dir);
	
	if (_this_x + label_w >= 0 && _this_x < WINDOW_BASE_SIZE) {
		draw_sprite_stretched(label_list[| i], 0, _this_x, (_yy + _y_hide_offset) - _vgap, label_w, label_h);
		draw_sprite_stretched(label_list_2[| i], 0, -_this_x +  (WINDOW_BASE_SIZE - label_w), ((_yy - (WINDOW_BASE_SIZE - (72))) - _y_hide_offset) + _vgap, label_w, label_h);
	}
	
}


// draw logo
if (!logo_draw_last) ___draw_logo();

