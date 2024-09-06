// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("chacon_not_enough_tacos", {
    config_version: 1,
    game_name: "Not Enough Tacos",
    authors : "Chacon",
    prompt: "Memorize!",
    init_room: chacon_not_enough_tacos_room_desert,
    view_width: 240,
    view_height: 160,
    time_seconds: 7,
    music_track: chacon_not_enough_tacos_bgm, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: false, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [245, 83, 71],
    cartridge_col_secondary: [148, 47, 40],
    cartridge_label: chacon_not_enough_tacos_sprite_cartridge,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Chacon"],
    date_added:{
	  day : 24,
	  month : 8,
	  year : 2099
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
});