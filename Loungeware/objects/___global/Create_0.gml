

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

//basically keyboard_lastkey but only keys allowed
___global.last_key = -1;

//-------------------------------------------------------------------------------------
// KEYCODE -> TEXT
// For control rebinding
//-------------------------------------------------------------------------------------
___global.keycode_to_str = [];
___global.keycode_to_str[vk_escape] = "Escape";
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
___global.keycode_to_str[145] = "Scroll Lock";
___global.keycode_to_str[vk_pause] = "Pause";
___global.keycode_to_str[192] = "Tilde(~)";
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
___global.keycode_to_str[189] = "Dash(-)";
___global.keycode_to_str[187] = "Equals(=)";
___global.keycode_to_str[vk_backspace] = "Backspace";
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
___global.keycode_to_str[219] = "L Bracket([)";
___global.keycode_to_str[221] = "R Bracket(])";
___global.keycode_to_str[220] = "Backslash(\\)";
___global.keycode_to_str[20] = "Capslock";
___global.keycode_to_str[186] = "Semi-Colon(;)";
___global.keycode_to_str[222] = "Apostrophe(')";
___global.keycode_to_str[13] = "Enter";
___global.keycode_to_str[160] = "L Shift";
___global.keycode_to_str[161] = "R Shift";
___global.keycode_to_str[162] = "L Control";
___global.keycode_to_str[163] = "R Control";
___global.keycode_to_str[164] = "L Alt";
___global.keycode_to_str[165] = "R Alt";
___global.keycode_to_str[188] = "Comma(,)";
___global.keycode_to_str[190] = "Period(.)";
___global.keycode_to_str[191] = "Slash(/)";
___global.keycode_to_str[vk_space] = "Spacebar";
___global.keycode_to_str[93] = "Apps";
___global.keycode_to_str[vk_insert] = "Insert";
___global.keycode_to_str[vk_home] = "Home";
___global.keycode_to_str[vk_pageup] = "Page Up";
___global.keycode_to_str[vk_delete] = "Delete";
___global.keycode_to_str[vk_end] = "End";
___global.keycode_to_str[vk_pagedown] = "Page Down";
___global.keycode_to_str[144] = "Numlock";
___global.keycode_to_str[111] = "Numpad Slash(/)";
___global.keycode_to_str[106] = "Numpad Asterisk(*)";
___global.keycode_to_str[109] = "Numpad Dash(-)";
___global.keycode_to_str[vk_numpad0] = "Numpad 0";
___global.keycode_to_str[vk_numpad1] = "Numpad 1";
___global.keycode_to_str[vk_numpad2] = "Numpad 2";
___global.keycode_to_str[vk_numpad3] = "Numpad 3";
___global.keycode_to_str[vk_numpad4] = "Numpad 4";
___global.keycode_to_str[vk_numpad5] = "Numpad 5";
___global.keycode_to_str[vk_numpad6] = "Numpad 6";
___global.keycode_to_str[vk_numpad7] = "Numpad 7";
___global.keycode_to_str[vk_numpad8] = "Numpad 8";
___global.keycode_to_str[vk_numpad9] = "Numpad 9";
___global.keycode_to_str[110] = "Numpad Period(.)";
___global.keycode_to_str[107] = "Numpad Plus(+)";
___global.keycode_to_str[vk_left] = "Left Arrow";
___global.keycode_to_str[vk_right] = "Right Arrow";
___global.keycode_to_str[vk_up] = "Up Arrow";
___global.keycode_to_str[vk_down] = "Down Arrow";

