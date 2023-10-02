// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("{ddgang}_{garyflip}", {
    config_version: 1,
    game_name: "Gary Flip",
    authors : "Doudoudodogang",
    prompt: "SELECT SMUG GARY",
    init_room: ddgang_garyflip_main,
    view_width: -1,
    view_height: -1,
    time_seconds: 6,
    music_track: sng_zandy_xylo, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [202, 203, 208],
    cartridge_col_secondary: [0, 0, 0],
    cartridge_label: ddgang_garyflip_label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Doudoudodogang"],
    date_added:{
	  day : 30,
	  month : 9,
	  year : 2023
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
});
