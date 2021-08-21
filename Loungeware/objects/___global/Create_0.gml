

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
