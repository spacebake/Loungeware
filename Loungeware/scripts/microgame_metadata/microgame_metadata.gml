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
	//space_rocket_lander: {
	//	game_name: "Rocket Lander",
	//	creator_name: "Space",
	//	prompt: "LAND",
	//	init_room: space_lander_rm_lander,
	//	view_width: 240,
	//	view_height: 160,
	//	time_seconds: 5,
	//	music_track: sng_zandy_descending,
	//	music_loops: true,
	//	interpolation_on: false,
	//	cartridge_col_primary: make_color_rgb(0, 214, 179),
	//	cartridge_col_secondary: make_color_rgb(0, 125, 150),
	//	cartridge_label: space_lander_label,
	//	default_is_fail: true,
	//	date_added: "21/07/05",
	//},
	//n8fl_penguin_blast: {
	//	game_name: "Penguin Blast",
	//	creator_name: "net8floz",
	//	prompt: "Don't Get Blasted",
	//	init_room: n8fl_penguin_blast_rm,
	//	view_width: 240,
	//	view_height: 160,
	//	time_seconds: 8,
	//	music_track: sng_zandy_descending,
	//	music_loops: true,
	//	interpolation_on: false,
	//	cartridge_col_primary: make_color_rgb(255, 255, 255),
	//	cartridge_col_secondary: make_color_rgb(243, 122, 97),
	//	cartridge_label: n8fl_penguin_blast_label,
	//	default_is_fail: true,
	//	date_added: "21/07/05",
	//},
	n8fl_reach_for_it_mister: {
		game_name: "Reach For It, Mister",
		creator_name: "net8floz",
		prompt: "Wait for it",
		init_room: n8fl_reach_for_it_mister_rm,
		view_width: 240,
		view_height: 160,
		time_seconds: 8,
		music_track: sng_zandy_descending,
		music_loops: true,
		interpolation_on: false,
		cartridge_col_primary: make_color_rgb(89, 62, 71),
		cartridge_col_secondary: make_color_rgb(122, 88, 89),
		cartridge_label: n8fl_reach_for_it_mister_label,
		default_is_fail: true,
		date_added: "21/07/05",
	},
	
	
}}





