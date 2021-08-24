// nullable fields may be omitted entirely
// if your game fails validatio, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading

//see https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("username_gamename", {
    config_version: 1,
    game_name: "EXAMPLE",
    authors :  "john doe",
    prompt: "PRESS",
    init_room: username_gamename_rm_game,
    view_width: 240,
    view_height: 160,
    time_seconds: 5,
    music_track: username_gamename_bgm_game, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [0, 0, 0],
    cartridge_col_secondary: [55, 255, 255],
    cartridge_label: username_gamename_spr_cartridge,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: false,
    credits: ["john doe", "jane doe"],
    date_added: {
		day: 17,
		month: 8,
		year: 2021
	},
	is_enabled: false
});