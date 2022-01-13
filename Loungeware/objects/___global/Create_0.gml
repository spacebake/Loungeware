

/* The one true global object,
this is created at the start of the game
and remains until the game is closed.
you can write to it using ___global.
do not use this object to store vars 
for your microgame, it is for base-game use only */


___song_stop_list = ds_list_create(); //___ds_list_create_builtin();
___audio_active_list = ds_list_create();

//-------------------------------------------------------------------------------------
// ADVANCED TEXT (alive shake)
//-------------------------------------------------------------------------------------
active_char_potential_letters = ds_list_create();
active_char_id_list = ds_list_create();
active_char_timer_list = ds_list_create();
active_char_timer_max = 10;
new_active_char_frequency = 15;
___init_advanced_text();

//-------------------------------------------------------------------------------------
// STORE MENU CURSOR POSITIONS
//-------------------------------------------------------------------------------------
___global.menu_cursor_main = 0;
___global.menu_cursor_gallery = 0;


// game window
window_set_size(540, 540);
___center_window();
window_set_min_width(540);
window_set_min_height(540);

//str_which is "up", "primary", etc
function toggle_controller_values(held, pressed, released, yesno, str_which) {
	var held_which = held[$ str_which];
	var pressed_which = pressed[$ str_which];
	var released_which = released[$ str_which];
	
	if (yesno) {
		if (!pressed_which) {
			if (!held_which) {
				pressed[$ str_which] = true;
			}
			
		} else {
			pressed[$ str_which] = false;	
		}
		
		held[$ str_which] = true;
		
	} else {
		pressed[$ str_which] = false;
		released[$ str_which] = false;
		
		if (held_which) {
			released[$ str_which] = true;	
		}
		
		held[$ str_which] = false;
		
	}
}

//basically keyboard_lastkey but only keys allowed
___global.last_key = -1;

//-------------------------------------------------------------------------------------
// KEYCODE -> TEXT
// For control rebinding
//-------------------------------------------------------------------------------------
___global.keycode_to_str = array_create(256);
for (var i = 0; i < array_length(___global.keycode_to_str); i++) {
	___global.keycode_to_str[i] = "?";	
}
___global.keycode_to_str[vk_escape] = "ESC";
___global.keycode_to_str[vk_f1] = "F1";
___global.keycode_to_str[vk_f2] = "F2";
___global.keycode_to_str[vk_f3] = "F3";
___global.keycode_to_str[vk_f4] = "F4";
___global.keycode_to_str[vk_f5] = "F5";
___global.keycode_to_str[vk_f6] = "F6";
___global.keycode_to_str[vk_f7] = "F7";
___global.keycode_to_str[vk_f8] = "F8";
___global.keycode_to_str[vk_f9] = "F9";
___global.keycode_to_str[vk_f10] = "F10";
___global.keycode_to_str[vk_f11] = "F11";
___global.keycode_to_str[vk_f12] = "F12";
___global.keycode_to_str[145] = "SCROLL";
___global.keycode_to_str[vk_pause] = "PAUSE";
___global.keycode_to_str[192] = "~";
___global.keycode_to_str[49] = "1";
___global.keycode_to_str[50] = "2";
___global.keycode_to_str[51] = "3";
___global.keycode_to_str[52] = "4";
___global.keycode_to_str[53] = "5";
___global.keycode_to_str[54] = "6";
___global.keycode_to_str[55] = "7";
___global.keycode_to_str[56] = "8";
___global.keycode_to_str[57] = "9";
___global.keycode_to_str[48] = "0";
___global.keycode_to_str[189] = "-";
___global.keycode_to_str[187] = "=";
___global.keycode_to_str[vk_backspace] = ___spr_backspace;
___global.keycode_to_str[vk_tab] = "TAB";
___global.keycode_to_str[65] = "A";
___global.keycode_to_str[66] = "B";
___global.keycode_to_str[67] = "C";
___global.keycode_to_str[68] = "D";
___global.keycode_to_str[69] = "E";
___global.keycode_to_str[70] = "F";
___global.keycode_to_str[71] = "G";
___global.keycode_to_str[72] = "H";
___global.keycode_to_str[73] = "I";
___global.keycode_to_str[74] = "J";
___global.keycode_to_str[75] = "K";
___global.keycode_to_str[76] = "L";
___global.keycode_to_str[77] = "M";
___global.keycode_to_str[78] = "N";
___global.keycode_to_str[79] = "O";
___global.keycode_to_str[80] = "P";
___global.keycode_to_str[81] = "Q";
___global.keycode_to_str[82] = "R";
___global.keycode_to_str[83] = "S";
___global.keycode_to_str[84] = "T";
___global.keycode_to_str[85] = "U";
___global.keycode_to_str[86] = "V";
___global.keycode_to_str[87] = "W";
___global.keycode_to_str[88] = "X";
___global.keycode_to_str[89] = "Y";
___global.keycode_to_str[90] = "Z";
___global.keycode_to_str[219] = "[";
___global.keycode_to_str[221] = "]";
___global.keycode_to_str[220] = @"\";
___global.keycode_to_str[20] = ___spr_capslock;
___global.keycode_to_str[186] = ___spr_enter;
___global.keycode_to_str[222] = "'";
___global.keycode_to_str[13] = ___spr_enter;
___global.keycode_to_str[160] = ___spr_lshift;
___global.keycode_to_str[161] = ___spr_rshift;
___global.keycode_to_str[162] = "LCTRL";
___global.keycode_to_str[163] = "RCTRL";
___global.keycode_to_str[164] = "LALT";
___global.keycode_to_str[165] = "RALT";
___global.keycode_to_str[188] = ",";
___global.keycode_to_str[190] = ".";
___global.keycode_to_str[191] = "/";
___global.keycode_to_str[vk_space] = "SPACE";
___global.keycode_to_str[93] = "APPS";
___global.keycode_to_str[vk_insert] = "INS";
___global.keycode_to_str[vk_home] = "HOME";
___global.keycode_to_str[vk_pageup] = "PAGE UP";
___global.keycode_to_str[vk_delete] = "DEL";
___global.keycode_to_str[vk_end] = "END";
___global.keycode_to_str[vk_pagedown] = "PAGE DOWN";
___global.keycode_to_str[144] = "NUMLOCK";
___global.keycode_to_str[111] = "NUMPAD /";
___global.keycode_to_str[106] = "NUMPAD *";
___global.keycode_to_str[109] = "NUMPAD -";
___global.keycode_to_str[vk_numpad0] = "NUMPAD 0";
___global.keycode_to_str[vk_numpad1] = "NUMPAD 1";
___global.keycode_to_str[vk_numpad2] = "NUMPAD 2";
___global.keycode_to_str[vk_numpad3] = "NUMPAD 3";
___global.keycode_to_str[vk_numpad4] = "NUMPAD 4";
___global.keycode_to_str[vk_numpad5] = "NUMPAD 5";
___global.keycode_to_str[vk_numpad6] = "NUMPAD 6";
___global.keycode_to_str[vk_numpad7] = "NUMPAD 7";
___global.keycode_to_str[vk_numpad8] = "NUMPAD 8";
___global.keycode_to_str[vk_numpad9] = "NUMPAD 9";
___global.keycode_to_str[110] = "NUMPAD .";
___global.keycode_to_str[107] = "NUMPAD +";
___global.keycode_to_str[vk_left] = ___spr_arrow_left;
___global.keycode_to_str[vk_right] = ___spr_arrow_right;
___global.keycode_to_str[vk_up] = ___spr_arrow_up;
___global.keycode_to_str[vk_down] = ___spr_arrow_down;

//-------------------------------------------------------------------------------------
// GAMEPAD BUTTON CONSTANT -> SPRITE
// For control rebinding
//-------------------------------------------------------------------------------------
___global.gp_to_str = ds_map_create();
___global.gp_to_str[? gp_face1] = ___spr_gp_face1;	//Top button 1 (this maps to the "A" on an Xbox 360 controller and the cross on a PS controller)
___global.gp_to_str[? gp_face2] = ___spr_gp_face2;	//Top button 2 (this maps to the "B" on an Xbox 360 controller and the circle on a PS controller)
___global.gp_to_str[? gp_face3] = ___spr_gp_face3;	//Top button 3 (this maps to the "X" on an Xbox 360 controller and the square on a PS controller)
___global.gp_to_str[? gp_face4] = ___spr_gp_face4;	//Top button 4 (this maps to the "Y" on an Xbox 360 controller and the triangle on a PS controller)
___global.gp_to_str[? gp_shoulderl] = ___spr_gp_shoulderl;	//Left shoulder button
___global.gp_to_str[? gp_shoulderlb] = ___spr_gp_shoulderlb;	//Left shoulder trigger
___global.gp_to_str[? gp_shoulderr] = ___spr_gp_shoulderr;	//Right shoulder button
___global.gp_to_str[? gp_shoulderrb] = ___spr_gp_shoulderrb;	//Right shoulder trigger
___global.gp_to_str[? gp_select] = ___spr_gp_select;	//The select button (on a DS4 controller, this triggers when you press the touchpad down)
___global.gp_to_str[? gp_start] = ___spr_gp_face1;	//The start button (this is the "options" button on a PS4 controller)
___global.gp_to_str[? gp_stickl] = ___spr_gp_face1;	//The left stick pressed (as a button)
___global.gp_to_str[? gp_stickr] = ___spr_gp_face1;	//The right stick pressed (as a button)
___global.gp_to_str[? gp_padu] = ___spr_gp_face1;	//D-pad up
___global.gp_to_str[? gp_padd] = ___spr_gp_face1;	//D-pad down
___global.gp_to_str[? gp_padl] = ___spr_gp_face1;	//D-pad left
___global.gp_to_str[? gp_padr] = ___spr_gp_face1;	//D-pad right
//___global.gp_to_str[? gp_axislh] = ___spr_gp_face1;	//	Left stick horizontal axis (analog)
//___global.gp_to_str[? gp_axislv] = ___spr_gp_face1;	//	Left stick vertical axis (analog)
//___global.gp_to_str[? gp_axisrh] = ___spr_gp_face1;	//	Right stick horizontal axis (analog)
//___global.gp_to_str[? gp_axisrv] = ___spr_gp_face1;	//	Right stick vertical axis (analog)