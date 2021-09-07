// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource,
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki:
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("sam_cookiedunk", {
    config_version: 1,
    game_name: "Cookie Dunk",
    authors : "Sam",
    prompt: "DUNK",
    init_room: sam_cd_rm_game,
    view_width: 480,
    view_height: 320,
    time_seconds: 5,
    music_track: noone, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: noone, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [50, 44, 63],
    cartridge_col_secondary: [168, 84, 100],
    cartridge_label: sam_cd_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Sam"],
    date_added:{
	  day : 4,
	  month : 9,
	  year : 2021
	},
	is_enabled: true,
	supports_html:true,
	show_on_website: true,
});

microgame_register("sam_catsnatch", {
    config_version: 1,
    game_name: "Cat Snatch",
    authors : "Sam",
    prompt: "SNATCH!",
    init_room: sam_cs_rm_game,
    view_width: 480,
    view_height: 320,
    time_seconds: 5,
    music_track: sng_zandy_claw_machine, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [10, 152, 172],
    cartridge_col_secondary: [130, 60, 61],
    cartridge_label: sam_cs_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Sam"],
    date_added:{
	  day : 6,
	  month : 9,
	  year : 2021
	},
	is_enabled: true,
	supports_html:true,
	show_on_website: true,
});
