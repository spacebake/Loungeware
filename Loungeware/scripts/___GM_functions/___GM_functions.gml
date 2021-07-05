// ------------------------------------------------------------------------------------------
// CARTRIDGE SHADER | turn on/off shader to recolor the cartridge to the colors specified in the microgame metadata
// ------------------------------------------------------------------------------------------
function ___shader_cartridge_on(_col1, _col2){

	var _r1 = (color_get_red(_col1)/255) + 0.0;
	var _g1 = (color_get_green(_col1)/255) + 0.0;
	var _b1 = (color_get_blue(_col1)/255) + 0.0;
	
	var _r2 = (color_get_red(_col2)/255) + 0.0;
	var _g2 = (color_get_green(_col2)/255) + 0.0;
	var _b2 = (color_get_blue(_col2)/255) + 0.0;

	
	var _color_new_primary = shader_get_uniform(___shd_cartridge, "color_new_primary");
	var _color_new_secondary = shader_get_uniform(___shd_cartridge, "color_new_secondary");
	shader_set(___shd_cartridge);
	shader_set_uniform_f(_color_new_primary, _r1, _g1, _b1, 1.0);
	shader_set_uniform_f(_color_new_secondary, _r2, _g2, _b2, 1.0);
	
	
}
function ___shader_cartridge_off(){
	shader_reset();
}


// ------------------------------------------------------------------------------------------
// CREATE CARTRIDGE SPRITE | creates a sprite for the microgame cartridge
// ------------------------------------------------------------------------------------------
function ___cart_sprite_create(_microgame_metadata){
	
	// create cart suface if it doesn't exist
	if (!surface_exists(surf_cart)){
		surf_cart = surface_create(sprite_get_width(___spr_gameboy_back), sprite_get_width(___spr_gameboy_back));
	}
	var _cart_x = sprite_get_xoffset(___spr_gameboy_back);
	var _cart_y = sprite_get_yoffset(___spr_gameboy_back);
	var _label_w = 304;
	var _label_h = 144;
	var _label_x = 38;
	var _label_y = 78;
	surface_set_target(surf_cart);
	draw_clear_alpha(c_white, 0);
	___shader_cartridge_on(_microgame_metadata.cartridge_col_primary, _microgame_metadata.cartridge_col_secondary);
	draw_sprite_ext(___spr_gameboy_back, 1, _cart_x , _cart_y, 1, 1, 0, c_white, 1);
	___shader_cartridge_off();
	if (sprite_exists(_microgame_metadata.cartridge_label)){
		draw_sprite_stretched(_microgame_metadata.cartridge_label, 0, _label_x, _label_y, _label_w/2, _label_h/2);
	}
	surface_reset_target();
	var _spr = sprite_create_from_surface(surf_cart, 0, 0, surface_get_width(surf_cart), surface_get_height(surf_cart), 0, 0, 7, 19 );
	ds_list_add(garbo_sprites, _spr);
	return _spr;
}

// ------------------------------------------------------------------------------------------
// PROMPT SPRITE CREATE | creates a temp sprite for the microgame prompt text
// ------------------------------------------------------------------------------------------
function ___prompt_sprite_create(microgame_key){
	var _scale = 0.5;
	var _w = canvas_w * _scale;
	var _h = canvas_h * _scale;
	var _surf = surface_create(_w, _h);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_frogtype);
	var _prompt_x = _w/2;
	var _prompt_y = _h/2;
	surface_set_target(_surf);
	draw_clear_alpha(c_white, 0);
	var _outline_rad = 3;
	
	// draw text outline
	draw_set_color(c_gbblack);
	for (var i = 0; i < 360; i += 20){
		draw_text_ext(
			_prompt_x + lengthdir_x(_outline_rad, i),
			_prompt_y + lengthdir_y(_outline_rad, i),
			string_upper(microgame_key.prompt) + "!", 
			16, 
			_w, 
		);
	}
	// draw text
	draw_set_color(c_gbwhite);
	draw_text_ext(
		_prompt_x,
		_prompt_y,
		string_upper(microgame_key.prompt) + "!", 
		16, 
		_w, 
	);
	
	surface_reset_target();
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var _spr = sprite_create_from_surface(_surf, 0, 0, _w, _h, 0, 0, _w/2, _h/2);
	ds_list_add(garbo_sprites, _spr);
	surface_free(_surf);
	return _spr;
}


// ------------------------------------------------------------------------------------------
// DRAW TITLE | DRAWS THE GAME TITLE FOR TRANSITION SEQUENCE
// ------------------------------------------------------------------------------------------
function ___draw_title(_x, _y){
	var _scale = 1;
	draw_set_font(fnt_frogtype);
	var _game_name = "\"" + string_upper(microgame_next_data.game_name) + "\"";
	var _game_creator = string_upper(microgame_next_data.creator_name);
	var _margin = 0;
	var _padding = 3;
	var _w = 174;
	var _sep = 14;
	var _name_h = string_height_ext(_game_name, _sep, _w) * _scale;
	var _name_w = string_width_ext(_game_name, _sep, _w) * _scale;
	var _creator_h = string_height_ext(_game_creator, _sep, _w) * _scale;
	var _creator_w = string_width_ext(_game_creator, _sep, _w) * _scale;
	var _max_w = max(_creator_w, _name_w);
	var _line_x1 = _x - (_max_w/2);
	var _line_x2 = _x + (_max_w/2);
	_y =  _y - ((_name_h + _creator_h + _margin)/2);

	draw_set_color(c_gbyellow);
	draw_set_halign(fa_center);

	draw_text_ext_transformed(_x, _y, _game_name, _sep, _w, _scale, _scale, 0);
	draw_set_color(c_gbpink);
	draw_rectangle_fix(_line_x1, (_y - _padding) - 2, _line_x2, _y - _padding);
	_y += (_name_h + _margin);
	draw_text_ext_transformed(_x, _y, _game_creator, _sep, _w, _scale, _scale, 0);
	_y += (_creator_h);
	draw_rectangle_fix(_line_x1, (_y + _padding) - 2, _line_x2, _y + _padding);
	draw_set_halign(fa_left);
	
}