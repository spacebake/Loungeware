// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("josh_eyes_on_eyes", {
    config_version: 1,
    game_name: "Spookeyes",
    authors : {
		josh_: "Josh",
		kilo: "Kilomatter"
	},
    prompt: "COUNT!",
    init_room: josh_eyes_rGame,
    view_width: 480,
    view_height: 270,
    time_seconds: 9,
    music_track: noone, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [50, 44, 63],
    cartridge_col_secondary: [168, 84, 100],
    cartridge_label: josh_eyes_sLabel,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: false,
    credits: ["Josh", "Kilomatter"],
    date_added:{
	  day : 6,
	  month : "November",
	  year : 2021
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description : ["Larold is being hunted down by some very bad demons! count how many they are!"],
    how_to_play : ["Pay close attention and count the pair of eyes you see on the screen."],
});