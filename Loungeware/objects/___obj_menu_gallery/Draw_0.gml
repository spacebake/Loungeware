// inputs
var _move = 0;
var _h_move = 0;
var _current_game_data = variable_struct_get(___global.microgame_metadata, microgame_keylist[cursor]);

if (state == "normal"){
	_move = -KEY_UP + KEY_DOWN;
	if (_move != previous_scroll_dir){
		input_cooldown = 0;
		input_is_scrolling = false;
	}
	previous_scroll_dir = _move;
	if (abs(_move) && input_cooldown <= 0){
		if (input_is_scrolling){
			input_cooldown = input_cooldown_max;
		} else {
			input_cooldown = input_cooldown_init_max;
			input_is_scrolling = true;
		}
		___sound_menu_tick_vertical();
		difficulty = 1;
	} else {
		_move = 0;
		input_cooldown = max(0, input_cooldown - 1);
	}
	
	_h_move = -KEY_LEFT_PRESSED + KEY_RIGHT_PRESSED;
	var _store_diff = difficulty;
	if (_current_game_data.supports_difficulty_scaling){
		difficulty = clamp(difficulty + _h_move, 1, ___global.difficulty_max);
	}
	if (difficulty != _store_diff) ___sound_menu_tick_horizontal();

	// confirm button
	if (KEY_PRIMARY_PRESSED){
		state = "move_cart";
		// stop sound
		audio_sound_gain(sng_id, 0, 300);
	}

	// back button OR escape key
	if (KEY_SECONDARY_PRESSED || keyboard_check_pressed(vk_escape)){
		state = "fadeout_back";
		fadeout_do =  back_to_main;
		// stop sound
		audio_sound_gain(sng_id, 0, 100);
	}
}


var _list_len = array_length(microgame_keylist);
cursor += _move;
if (cursor > _list_len-1) cursor = 0;
if (cursor < 0) cursor = _list_len -1;

// draw bg
draw_set_halign(fa_left);
draw_set_color(col_bg);
draw_rectangle_fix(0, 0, VIEW_W, VIEW_H);

var _margin = 28;
var _game_info_display_w = VIEW_W/2;

// draw divider
var _div_margin = _margin;
var _div_w = 4;
var _div_x1 = (VIEW_W - (_game_info_display_w + (_margin*2))) + 8;
var _div_x2 = _div_x1 + _div_w;
var _div_y1 = _div_margin;
var _div_y2 = VIEW_H - _div_margin;
draw_set_color(col_bar);
draw_rectangle_fix(_div_x1, _div_y1, _div_x2, _div_y2);


// draw menu entries
draw_set_font(___fnt_gallery_elipses);
draw_set_color(c_gbwhite);
var _list_margin_x = 8;
var _list_margin_y = _div_y1;
var _list_x = _list_margin_x;
var _list_line_sep = 15;
var _list_y = floor(_list_margin_y + scroll_y + _list_line_sep*0.5);
var _list_line_height = 20;
var _list_max_w = _div_x1 - (_list_margin_x*2);
var _list_letter_sep = 0;
var _list_max_chars = 18;
var _list_total_h = 0;
var _cursor_y = 0;

scroll_y = ___smooth_move(scroll_y, scroll_y_target, 0.5, 5);



for (var i = 0; i < array_length(microgame_keylist); i++){
	var _key = microgame_keylist[i];
	var _data = variable_struct_get(___global.microgame_metadata, _key);
	var _name = string_upper(_data.game_name);
	var _char_count = string_length(_name);
	var _xx = _list_x;
	var _store_y = _list_y;
	var _in_view = (_list_y > 0 && _list_y < VIEW_H);
	var _text_adjust_y = 2;
	
	if (i == cursor) {
		
		draw_set_color(col_bar);
		var x1 = 0;
		var y1 = _list_y - _list_line_sep*0.5;
		var x2 = _div_x1 - 2;
		var y2 = _list_y + _list_line_height;
		draw_rectangle(x1, y1-3, x2+1, y2+5, false);
		draw_set_color(c_gbyellow);
	}
	
	
	// draw mini cart
	___shader_cartridge_on(_data);
	draw_sprite(___spr_cart_smol, 0, _xx, (_list_y-2) + _text_adjust_y);
	___shader_cartridge_off();
	_xx += sprite_get_width(___spr_cart_smol) + 8;
	
	if (_char_count > _list_max_chars){
		_name = string_copy(_name, 1, _list_max_chars-1);
		_name = ___global.___string_trim_whitespace(_name);
		_name += "~";
		
	}
	
	_name = ___global.___DTA_linebreak_pixels(_name, _list_max_w + 32, draw_get_font(), _list_letter_sep);
	var _lines = string_count("\n", _name)+1;
	draw_set_color(c_gbwhite);
	if (i == cursor){
		draw_set_color(c_gbyellow);
		_name = "<wave>" + _name;
		scroll_y_target = ((VIEW_H/2)-25) - (_list_total_h);
		if (scroll_skip){
			scroll_y = scroll_y_target;
			scroll_skip = false;
		}
		_cursor_y = _list_y;
	}
	
	if (_in_view){
		___global.___draw_text_advanced(
			_xx,
			_list_y + _text_adjust_y,
			_list_line_height, 
			true, true,
			_name,
			1, 1, _list_letter_sep
		)
	}

	_list_y += (_list_line_height * _lines) + (_list_line_sep/2);

	// draw seperator line
	draw_set_color(col_bar);
	var _dot_size = 2;
	
	if (_in_view){
		if (i != array_length(microgame_keylist)-1){
			draw_dotted_line(_list_x, _list_y-2, _list_x + _list_max_w, _list_y-2, _dot_size, _dot_size);
		}
	}
	
	_list_y += _list_line_sep/2;
	
	var _y_change = _list_y - _store_y;
	_list_total_h += _y_change;
}

// limit scroll
scroll_y_target = clamp(scroll_y_target, -_list_total_h, 0);

// draw pointer
//draw_sprite(___spr_gallery_arrows, 2, _div_x1, _cursor_y-5);

// draw covers
draw_set_color(col_bar);
var _cover_height = _div_y1;
var _bar_y = (VIEW_H - (_cover_height));
var _arrow_fade_steps = 10;

// draw bottom cover
var _show_bottom_cover = (_list_y > VIEW_H);
draw_set_color(col_bg);

draw_rectangle_fix(0, _bar_y, _div_x1, VIEW_H);
draw_set_alpha(bottom_cover_prog);
draw_sprite(___spr_gallery_arrows, 0, _div_x1 / 2, _bar_y);
draw_set_alpha(1);

if (_show_bottom_cover){
	bottom_cover_prog = min(1, bottom_cover_prog + (1/_arrow_fade_steps));
} else {
	bottom_cover_prog = max(0, bottom_cover_prog - (1/_arrow_fade_steps));
}

// draw top cover
var _show_top_cover = (_list_y - _list_total_h < 0);
var _bar_y = _cover_height;
draw_set_color(col_bg);

draw_rectangle_fix(0, 0, _div_x1, _bar_y)
draw_set_alpha(top_cover_prog);
draw_sprite(___spr_gallery_arrows, 1, _div_x1 / 2, _bar_y - sprite_get_height(___spr_gallery_arrows));
draw_set_alpha(1);

if (_show_top_cover){
	top_cover_prog = min(1, top_cover_prog + (1/_arrow_fade_steps));
} else {
	top_cover_prog = max(0, top_cover_prog - (1/_arrow_fade_steps));
}


// draw cart
var _label = _current_game_data.cartridge_label;
var _cart_margin_x = ((VIEW_W - _div_x2) - sprite_get_width(___spr_cart_gallery))/2;
var _cart_margin_y = _margin;
var _cart_x = _div_x2 + _cart_margin_x;
var _cart_y = _margin;
var _cart_float_rad = 2;
var _cart_float_y = lengthdir_y(_cart_float_rad, cart_float_dir);
cart_float_dir += 3;
if (cart_float_dir >= 360) cart_float_dir -= 360;

if (state == "normal"){
	cart_x = _cart_x;
	cart_y = _cart_y + _cart_float_y;
}

___shader_cartridge_on(_current_game_data);
draw_sprite(___spr_cart_gallery, 1, cart_x, cart_y);
___shader_cartridge_off();
var _label_x = cart_x + 11;
var _label_y = cart_y + 65;
draw_sprite(_label, 0, _label_x, _label_y);
_cart_y += sprite_get_height(___spr_cart_gallery) + _cart_margin_y;

// draw cart seperator (under)
draw_set_color(col_bar);
draw_dotted_line(_div_x2 + _margin, _cart_y, VIEW_W - _margin, _cart_y, 3, 3);

// draw game name
//var _col_primary = _current_game_data.cartridge_col_primary;
//var _col_secondary = _current_game_data.cartridge_col_primary;
var _info_x = (VIEW_W/2) + (_div_x2/2);
var _info_y = (_cart_y + (_cart_margin_y/2))-2;
var _game_name = string_upper(_current_game_data.game_name);
var _text_sep = 30

_game_name = ___global._DTA_linebreak_chars(_game_name, 21);
draw_set_color(c_gbyellow);
draw_set_halign(fa_center);
draw_set_font(fnt_gallery);
_game_name = _game_name;
___global.___draw_text_advanced(_info_x, _info_y, _text_sep, true, true, _game_name, 1, 1, 0);
var _lines = string_count("\n" , _game_name);
_info_y += _lines * _text_sep;
_info_y += _margin;

// creator name
var _authors = string_upper(_current_game_data.authors);
_authors = ___global._DTA_linebreak_chars(_authors, 30);

draw_set_color(c_gbpink);
draw_set_font(fnt_frogtype);
___global.___draw_text_advanced(_info_x, _info_y, 30, true, true, _authors, 1, 1, 0);
var _lines = string_count("\n" , _authors);
_info_y += _lines * _text_sep;
_info_y += _margin;
_info_y -= 3;

// divider
// draw cart seperator (under creator name)
draw_set_color(col_bar);
draw_dotted_line(_div_x2 + _margin, _info_y, VIEW_W - _margin, _info_y, 3, 3);

// draw difficulty
var _str = "DIFFICULTY: ";
if (_current_game_data.supports_difficulty_scaling){
	draw_set_color(c_gbwhite);
	_str += string(difficulty);
} else {
	_str += "1";
	draw_set_color(col_date);
}
_info_y += (_cart_margin_y/2)-2;


var _str_w = floor((string_width(_str) + 8)/2);
___global.___draw_text_advanced(_info_x, _info_y, 30, true, true, _str, 1, 1, 0);

if (_current_game_data.supports_difficulty_scaling){
	draw_sprite(___spr_gallery_arrows, 2, _info_x - _str_w, _info_y - 5);
	draw_sprite(___spr_gallery_arrows, 3, _info_x + _str_w, _info_y - 5);
} else {
	draw_rectangle_fix(_info_x - _str_w, _info_y + 5, _info_x + _str_w, _info_y + 7)
}


// divider
// draw cart seperator (under difficulty)
_info_y += string_height("W");
_info_y += (_cart_margin_y/2)-2;
draw_set_color(col_bar);
draw_dotted_line(_div_x2 + _margin, _info_y, VIEW_W - _margin, _info_y, 3, 3);


// draw date
_info_y += (_cart_margin_y/2)-2;
var _date = date_nicify(_current_game_data.date_added);

draw_set_color(col_date);
___global.___draw_text_advanced(_info_x, _info_y, 30, true, true, _date, 1, 1, 0);

_info_y += string_height("W");
_info_y += (_cart_margin_y/2)-2;
// divider
// draw cart seperator (under date)
draw_set_color(col_bar);
draw_dotted_line(_div_x2 + _margin, _info_y, VIEW_W - _margin, _info_y, 3, 3);
_info_y += (_cart_margin_y/2)-2;

// draw credits
var _credits = _current_game_data.credits;
var _credits_str = "";

draw_set_color(col_date);
for (var i = 0; i < array_length(_credits); i++){
	var _name = string_upper(_credits[i]);
	_credits_str += _name;
	if (i < array_length(_credits) -1) _credits_str += ", ";
}

var _credits_line_h = 25;
_credits_str = ___global._DTA_linebreak_chars(_credits_str, 26)
___global.___draw_text_advanced(_info_x, _info_y, _credits_line_h, true, true, _credits_str, 1, 1, 0);
var _credits_line_count = 1 + string_count("\n", _credits_str);
_info_y += _credits_line_h * _credits_line_count;


// draw sep (under credits)
draw_set_color(col_bar);
_info_y += 4;
draw_dotted_line(_div_x2 + _margin, _info_y, VIEW_W - _margin, _info_y, 3, 3);
_info_y += (_cart_margin_y/2)-2;

var _size = WINDOW_BASE_SIZE/2;
if (!surface_exists(surf_circle)){
	surf_circle = surface_create(_size, _size);
}

// draw button guide
if (button_guide_alpha > 0 && ___global.show_button_prompts_menu){
	draw_set_alpha(button_guide_alpha);
	draw_sprite(___spr_back_prompt, 2, 0, 0);
	draw_set_alpha(1);
}


if (state == "fadeout_back"){
	surface_set_target(surf_circle);
	draw_clear(col_bg);
	gpu_set_blendmode(bm_subtract);
	draw_circle(_size/2, (_size/2)/*-30*/, close_circle_prog * ( _size*0.8), 0);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
	draw_surface_stretched(surf_circle, 0, 0, VIEW_W, VIEW_H);

}

// draw open transition cover
if (cover_alpha > 0){
	draw_set_color(col_bg);
	draw_set_alpha(cover_alpha);
	draw_rectangle_fix(0, 0, VIEW_W, VIEW_H);
	draw_set_alpha(1);
	if (state == "normal") cover_alpha = max(0, cover_alpha - (1/10));
}


if (state == "move_cart"){
	var _cart_goto_x = 182;
	var _cart_goto_y = 54;
	var _min = 0.5;
	var _div = 10;
	cart_x = ___smooth_move(cart_x, _cart_goto_x, _min, _div);
	cart_y = ___smooth_move(cart_y, _cart_goto_y, _min, _div);
	var _cart_on_target = cart_x == _cart_goto_x && cart_y == _cart_goto_y;
	cover_alpha = min(1, cover_alpha + (1/10));
	
	___shader_cartridge_on(_current_game_data);
	draw_sprite(___spr_cart_gallery, 1, cart_x, cart_y);
	___shader_cartridge_off();
	var _label_x = cart_x + 11;
	var _label_y = cart_y + 65;
	draw_sprite(_label, 0, _label_x, _label_y);
	_cart_y += sprite_get_height(___spr_cart_gallery) + _cart_margin_y;
	

	var _gameboy_goto_y = 230;
	gameboy_y = ___smooth_move(gameboy_y, _gameboy_goto_y, _min, _div);
	var _gameboy_on_target = gameboy_y == _gameboy_goto_y;
	draw_sprite(___spr_gameboy_back, 0, gameboy_x, gameboy_y);
	
	if (_cart_on_target && _gameboy_on_target){
		state = "start_game";
	}

}




