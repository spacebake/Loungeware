randomize();
played_record = [];
fnt_gallery = ___global.___fnt_gallery;
___state_setup("start");

___MG_MNGR_declare_functions();
___MG_MNGR_declare_variables();
application_surface_draw_enable(false);
step = -1;


//--------------------------------------------------------------------------------------------------------
// IF DEV CONFIG SAVE FILE IS FOUND, SET TEST MODE AND LOAD CHOSED MICROGAME
//--------------------------------------------------------------------------------------------------------
if (!TEST_MODE_ACTIVE){
	microgame_load_fake();
	room_goto(___rm_restroom);
	___state_change("intro");
} else {

	// get which game to load from config file
	var  _game_key = ___dev_config_get_test_key();
	___state_change("playing_microgame");
	
	// This should only run when launching the game in debug mode (prompt is usually set in step event)
	prompt =  microgame_get_prompt(_game_key);
	
	if (!instance_exists(___dev_debug)) instance_create_layer(0, 0, layer, ___dev_debug);
	microgame_start(_game_key);
} 


//___state_change("dev_test");
