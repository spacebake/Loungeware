// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


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
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [50, 44, 63],
    cartridge_col_secondary: [168, 84, 100],
    cartridge_label: johndoe_examplegame_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Noah R. - programming", "Water - graphics", "sidetilt - audio"],
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
		"Mash buttons to cheat. Don't cheat when teacher turns around."
	]
});
