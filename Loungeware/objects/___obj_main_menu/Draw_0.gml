if (state == "begin" && state_begin){
	// this has to be in the draw event for first frame reasons
	if (skip_intro && !logo_disable_zoom_intro) logo_scale = 0;

}

if (bg_show){
	var _bg_alpha = 0.2;
	var _bg_x = VIEW_W/2;
	var _bg_y = VIEW_H/2;
	var _bg_scale = 1.05 * bg_scale;
	draw_sprite_ext(___spr_mainmenu_bg_small, bg_frame, _bg_x, _bg_y, _bg_scale*2, _bg_scale*2, bg_spin, c_white, _bg_alpha);
	draw_sprite_ext(___spr_mainmenu_bg_small2, bg_frame, _bg_x, _bg_y, (_bg_scale*1.1)*2, (_bg_scale*1.25)*2, -bg_spin, c_white, _bg_alpha);
	bg_frame += 0.5;
}

//------------------------------------------------------------------------------------------
// STATE | *
//------------------------------------------------------------------------------------------

// draw logo
var _logo_x = VIEW_W/2;
var _logo_y = logo_y_target;
if (logo_shake_timer > 0){
	var _sv = 5;
	_logo_x += random_range(-_sv, _sv);
	_logo_y += random_range(-_sv, _sv);
}

draw_sprite_ext(___spr_logo_title, 1, _logo_x, _logo_y, logo_scale, logo_scale, 0, c_white, min(1, logo_scale));
	
// draw meu
var _text_x = VIEW_W/2;
var _text_y = menu_y - 16;
	
____menu_text_vertical_draw(
	_text_x,
	_text_y,
	menu,
	cursor,
	menu_confirmed
);


//------------------------------------------------------------------------------------------
// button prompt
//------------------------------------------------------------------------------------------
if (button_prompt_alpha > 0){
	draw_set_alpha(button_prompt_alpha);
	draw_sprite(___spr_back_prompt, 5, 0, 0);
	draw_set_alpha(1);
}

//------------------------------------------------------------------------------------------
// STATE | FADEOUT
//------------------------------------------------------------------------------------------
if (state == "fadeout"){
	
	var _size = WINDOW_BASE_SIZE/2;
	if (!surface_exists(circle_surf)){
		circle_surf = surface_create(_size, _size);
	}

	surface_set_target(circle_surf);
	draw_clear(c_gbdark);
	gpu_set_blendmode(bm_subtract);
	draw_circle(_size/2, (_size/2), close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);

	surface_reset_target();
	draw_surface_stretched(circle_surf, 0, 0, VIEW_W, VIEW_H);

}

