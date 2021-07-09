function ___init_metadata(){
	// ---------------------------------------------------------------------------------------------------------------
	SET_TEST_VARS {
		test_mode_on: false,  // Default false | Whether or not to run the game in test mode
		microgame_key: "",    // Default ""    | The key for your game, as a string. ("key" meaning the property name for your game in the metadata)
		loop_game: false,     // Default false | Whether or not to instantly restart the test microgame when it ends
		difficulty_level: 1,  // Default 1     | The difficulty level to run the test at (1-5). 
		mute_test: false,     // Default false | if true, mutes all audio when running the game in test mode
							  // You can access the difficutly level in your game using the "DIFFICULTY" var.
	} 
	
	var rules =  new LW_FGameLoaderRuleBuilder()
		.add_rule(
			new LW_FGameLoaderNumberTransformer("config_version", 0)
				.add_validator(function(version){ return version == 1; })
		)
		.add_rule(new LW_FGameLoaderStringTransformer("game_name", undefined))
		.add_rule(new LW_FGameLoaderStringTransformer("creator_name", undefined))
		.add_rule(new LW_FGameLoaderStringTransformer("prompt", undefined))
		.add_rule(new LW_FGameLoaderRoomTransformer("init_room", undefined))
		.add_rule(
			new LW_FGameLoaderNumberTransformer("view_width", -1)
				.set_nullable()
				.add_validator(function(view_width){
					return view_width == -1 || view_width > 32;	
				})
		)
		.add_rule(
			new LW_FGameLoaderNumberTransformer("view_height", -1)
				.set_nullable()
				.add_validator(function(view_height){
					return view_height == -1 || view_height > 32;	
				})
		)
		.add_rule(new LW_FGameLoaderNumberTransformer("time_seconds", -1).set_min(3).set_max(12))
		.add_rule(new LW_FGameLoaderSoundTransformer("music_track", noone).set_nullable())
		.add_rule(new LW_FGameLoaderBoolTransformer("music_loops", true).set_nullable())
		.add_rule(new LW_FGameLoaderBoolTransformer("interpolation_on", undefined))
		.add_rule(new LW_FGameLoaderColourTransformer("cartridge_col_primary", undefined))
		.add_rule(new LW_FGameLoaderColourTransformer("cartridge_col_secondary", undefined))
		.add_rule(new LW_FGameLoaderSpriteTransformer("cartridge_label", undefined))
		.add_rule(new LW_FGameLoaderBoolTransformer("default_is_fail", undefined))
		.add_rule(new LW_FGameLoaderBoolTransformer("supports_difficulty_scaling", undefined).set_nullable())
		.add_rule(
			new LW_FGameLoaderArrayTransformer("credits", undefined)
				.set_min(1)
				.set_inner_validator(function(val) { return is_string(val); })
			)
		.add_rule(new LW_FGameLoaderStringTransformer("date_added", undefined))
		.get_rules();

	var val = new LW_FGameLoader().get_configs(rules);
	return val;
}