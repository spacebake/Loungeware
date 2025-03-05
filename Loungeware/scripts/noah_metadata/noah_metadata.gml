// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("noah_makimono", {
    config_version: 1,
    game_name: "Makimono",
    authors : {noah: "Noah Reeves"},
    prompt: "HOP",
    init_room: noah_makimono_rm_main,
    view_width: 960,
    view_height: 640,
    time_seconds: 6,
    music_track: noah_makimoto_bgm, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [198, 190, 132],
    cartridge_col_secondary: [138, 111, 48],
    cartridge_label: noah_cheat_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Noah Reeves"],
    date_added:{
	  day : 3,
	  month : 3,
	  year : 2025
	},
	is_enabled: true,
	supports_html: true,
	supports_pi: true,
	show_on_website: true,
	description: [
		"Pilot the rocket mech and neutralize the enemy.", 
	],
	how_to_play: [
		"Aim with left and right and then press Z or X to fire."
	]
});

microgame_register("noah_artillery", {
    config_version: 1,
    game_name: "Artillery",
    authors : {noah: "Noah Reeves"},
    prompt: "DESTROY",
    init_room: noah_artillery_rm_main,
    view_width: 240,
    view_height: 160,
    time_seconds: 6,
    music_track: noah_artillery_bgm, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: false, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [198, 190, 132],
    cartridge_col_secondary: [138, 111, 48],
    cartridge_label: noah_cheat_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Noah Reeves"],
    date_added:{
	  day : 3,
	  month : 3,
	  year : 2025
	},
	is_enabled: true,
	supports_html: true,
	supports_pi: true,
	show_on_website: true,
	description: [
		"Pilot the rocket mech and neutralize the enemy.", 
	],
	how_to_play: [
		"Aim with left and right and then press Z or X to fire."
	]
});

microgame_register("noah_cheat", {
    config_version: 1,
    game_name: "Cheat",
    authors : {noah: "Noah Reeves"},
    prompt: "CHEAT",
    init_room: noah_cheat_rm_main,
    view_width: 480,
    view_height: 320,
    time_seconds: 8,
    music_track: noone, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: false, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [80, 148, 80],
    cartridge_col_secondary: [57, 104, 56],
    cartridge_label: noah_cheat_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Noah R. - programming", "Water (Imp) - graphics", "sidetilt - audio"],
    date_added:{
	  day : 7,
	  month : 1,
	  year : 2025
	},
	is_enabled: true,
	supports_html: true,
	supports_pi: true,
	show_on_website: true,
	description: [
		"You forgot to study! Cheat on your test, but don't let teacher catch you.", 
	],
	how_to_play: [
		"Mash the DOWN key to cheat. Don't cheat when teacher is watching."
	]
});


