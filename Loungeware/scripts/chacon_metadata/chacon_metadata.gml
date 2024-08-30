// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("chacon_not_enough_tacos", {
    config_version: 1,
    game_name: "Not Enough Tacos",
    authors : "Alejandro Chacon",
    prompt: "Memorize Order!",
    init_room: chacon_not_enough_tacos_room_desert,
    view_width: 240,
    view_height: 160,
    time_seconds: 5,
    music_track: noone, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [50, 44, 63],
    cartridge_col_secondary: [168, 84, 100],
    cartridge_label: johndoe_examplegame_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: false,
    credits: ["Alejandro Chacon"],
    date_added:{
	  day : 24,
	  month : 8,
	  year : 2024
	},
	is_enabled: false,
	supports_html:false,
	show_on_website: false,
});