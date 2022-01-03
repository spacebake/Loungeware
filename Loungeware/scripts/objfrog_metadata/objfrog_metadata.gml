// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("objfrog_parking_plunder", {
    config_version: 1,
    game_name: "Parking Plunder",
    authors : "objFrog",
    prompt: "PARK",
    init_room: objfrog_pp_r_init,
    view_width: 240,
    view_height: 160,
    time_seconds: 12,
    music_track: sng_ennway_bit_battle, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [150, 150, 30],
    cartridge_col_secondary: [215, 215, 30],
    cartridge_label: objfrog_pp_s_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["objFrog", "ennway"],
    date_added:{
	  day : 23,
	  month : 11,
	  year : 2021
	},
	is_enabled: true,
	supports_html: true,
	supports_pi: true,
	show_on_website: true,
	description: [
		"Park your car in the marked spot. That's all there is to it, stinker.", 
	],
	how_to_play: [
		"Left/right to turn, A to accelerate, B to reverse.",
	],
});


microgame_register("objfrog_yeehaw_shooter", {
    config_version: 1,
    game_name: "Yeehaw Shooter",
    authors : "objFrog",
    prompt: "SPIN 'N SHOOT",
    init_room: objfrog_ys_room,
    view_width: 240,
    view_height: 160,
    time_seconds: 10,
    music_track: objfrog_ys_music, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [110, 80, 35],
    cartridge_col_secondary: [165, 115, 45],
    cartridge_label: objfrog_ys_s_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["objFrog", "@wise1studio", "space", "Zandy"],
    date_added:{
	  day : 3,
	  month : 11,
	  year : 2021
	},
	is_enabled: true,
	supports_html: true,
	supports_pi: true,
	show_on_website: true,
	description: [
		"Practice yer' aim in the wild west by shootin' some targets. Hit 'em all within the time limit.", 
	],
	how_to_play: [
		"Left and right to spin, A to shoot."
	],
});
