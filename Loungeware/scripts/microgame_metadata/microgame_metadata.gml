function ___init_metadata(){
	
	// ---------------------------------------------------------------------------------------------------------------
	SET_TEST_VARS {
		test_mode_on: false,  // Default false | Whether or not to run the game in test mode
		microgame_key: "",    // Default ""    | The key for your game, as a string. ("key" meaning the property name for your game in the metadata)
		loop_game: false,     // Default false | Whether or not to instantly restart the test microgame when it ends
		difficulty_level: 1,  // Default 1     | The difficulty level to run the test at (1-5). 
							  // You can access the difficutly level in your game using the "DIFFICULTY" var.
	} return {
	// please set these values back to the defaults before you submit your game
	// ---------------------------------------------------------------------------------------------------------------


	/* TEMPLATE:
	(check the microgame_metadata_help file for more info on what these properties do)
	
	// (creator) game name
	johndoe_examplegame: {
		game_name: "Example Game",
		creator_name: "john doe",
		prompt: "SHOOT",
		init_room: johndoe_examplegame_rm_init,
		view_width: 240,
		view_height: 160,
		time_seconds: 5,
		music_track: noone,
		music_loops: true,
		interpolation_on: false,
		cartridge_col_primary: make_color_rgb(0, 0, 0),
		cartridge_col_secondary: make_color_rgb(255, 255, 255),
		cartridge_label: johndoe_examplegame_spr_label,
		default_is_fail: true,
		date_added: "YY/MM/DD",
	},
	*/
	
	// (SPACE) Rocket Lander
	space_rocket_lander: {
		game_name: "Rocket Lander",
		creator_name: "Space",
		prompt: "LAND",
		init_room: space_lander_rm_lander,
		view_width: 240,
		view_height: 160,
		time_seconds: 5,
		music_track: sng_zandy_descending,
		music_loops: true,
		interpolation_on: false,
		cartridge_col_primary: make_color_rgb(0, 214, 179),
		cartridge_col_secondary: make_color_rgb(0, 125, 150),
		cartridge_label: space_lander_label,
		default_is_fail: true,
		date_added: "21/07/05",
	},
	
	// (Mimpy) Test Name
	mimpy_firealarm: {
		game_name: "Fire Alarm",
		creator_name: "Mimpy",
		prompt: "DOUSE",
		init_room: mimpy_firealarm_rm,
		view_width: 240,
		view_height: 160,
		time_seconds: 5,
		music_track: sng_ennway_bit_battle,
		music_loops: true,
		interpolation_on: false,
		cartridge_col_primary: make_color_rgb(200, 64, 28),
		cartridge_col_secondary: make_color_rgb(102, 30, 32),
		cartridge_label: mimpy_firealarm_label,
		default_is_fail: true,
		date_added: "21/07/06",
	},

}}





