// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("objfrog_yeehaw_shooter", {
    config_version: 1,
    game_name: "Example Game",
    authors : "john doe",
    prompt: "SPIN 'N SHOOT",
    init_room: objfrog_ys_room,
    view_width: 240,
    view_height: 160,
    time_seconds: 12,
    music_track: false, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: false, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [50, 44, 63],
    cartridge_col_secondary: [168, 84, 100],
    cartridge_label: johndoe_examplegame_spr_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: false,
    credits: ["john doe", "jane doe"],
    date_added:{
	  day : 25,
	  month : 7,
	  year : 2099
	},
	is_enabled: false,
	supports_html:false,
	show_on_website: false,
});
