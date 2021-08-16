// nullable fields may be omitted entirely
// if your game fails validatio, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading
//microgame_register("{your_author_name}_{your_unique_game_name}", {
    //config_version: 1,
    //game_name: "Example Game",
    //creator_name : "john doe",
    //prompt: "SHOOT",
    //init_room: rm_some_room,
    //view_width: 240,
    //view_height: 160,
    //time_seconds: 5,
    //music_track: snd_my_awesome_snd, // nullable, defaults to noone. Accepts: sound name or false
    //music_loops: true, // nullable, defaults to true
    //interpolation_on: false,
    //cartridge_col_primary: [0, 0, 0],
    //cartridge_col_secondary: [55, 255, 255],
    //cartridge_label: johndoe_examplegame_spr_label,
    //default_is_fail: true, // nullable, defaults to true
    //supports_difficulty_scaling: false,
    //credits: ["john doe", "jane doe"],
    //date_added: "YY/MM/DD",
	//is_enabled: false
//});