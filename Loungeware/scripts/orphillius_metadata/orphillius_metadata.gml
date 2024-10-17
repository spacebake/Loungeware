// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("orphillius_lunch", {
    config_version: 1,
    game_name: "Lunch Service",
    authors : "Orphillius",
    prompt: "Serve",
    init_room: orphillius_lunch_rm,
    view_width: 480,
    view_height: 320,
    time_seconds: 7,
    music_track: sng_orphillius_zany, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: true,
    cartridge_col_primary: [204,171,40],
    cartridge_col_secondary: [153,9,38],
    cartridge_label: orphillius_lunch_label_sp,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Orphillius"],
    date_added:{
	  day : 18,
	  month : 6,
	  year : 2024
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"It's lunch time and the crowd is rolling in!"
	],
	how_to_play: [
		"Watch the customers' reactions and serve them the food they want."
	],
});

microgame_register("orphillius_pet", {
    config_version: 1,
    game_name: "Perfect Petsitter",
    authors : "Orphillius",
    prompt: "Care",
    init_room: orphillius_pet_rm,
    view_width: 480,
    view_height: 320,
    time_seconds: 7,
    music_track: sng_orphillius_zany, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [0,0,0],
    cartridge_col_secondary: [255,255,255],
    cartridge_label: orphillius_pet_label_sp,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["Orphillius"],
    date_added:{
	  day : 4,
	  month : 10,
	  year : 2024
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Your new pet has just arrived! Take care of it and watch it grow!"
	],
	how_to_play: [
		"Satisfy your pet's requests and clean up after it!"
	],
});