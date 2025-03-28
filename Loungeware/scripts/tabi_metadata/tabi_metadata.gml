// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("tabi_gogogatsby", {
    config_version: 1,
    game_name: "Go Go Gatsby",
    authors:{tabicoh : "Tabicoh", gatsby : "Gatsby"},
    prompt: "DODGE",
    init_room: tabi_gogogatsby_rm_gatsby,
    view_width: 480,
    view_height: 320,
    time_seconds: 6,
    music_track: tabi_gogogatsby_bgm_game373,
    music_loops: false,
    interpolation_on: true,
    cartridge_col_primary: [253, 244, 81],
    cartridge_col_secondary: [231, 135, 21],
    cartridge_label: tabi_gogogatsby_spr_label,
    default_is_fail: false,
    supports_difficulty_scaling: false,
    credits: ["Tabicoh", "Gatsby"],
    date_added:{
	  day : 28,
	  month : 3,
	  year : 2025,
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Drive down the freeway without hitting anyone you know", 
	],
	how_to_play: [
		"Press up and down to dodge Gatsby's friends as he speeds down the highway!"
	]
});
