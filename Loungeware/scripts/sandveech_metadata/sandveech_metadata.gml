// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("sandveech_bergur", {
  config_version: 1,
  game_name: "Bergur",
  authors : "Nompang Studios",
  prompt: "Make Good Bergur!",
  init_room: sandveech_bg_rm_main,
  view_width: -1,
  view_height: -1,
  time_seconds: 5,
  music_track: noone,//sng_zandy_catjam, // nullable, defaults to noone. Accepts: sound name or false
  music_loops: false, // nullable, defaults to true
  interpolation_on: false,
  cartridge_col_primary: [116, 164, 60],
  cartridge_col_secondary: [71, 136, 23],
  cartridge_label: pixpope_hp_spr_label,
  default_is_fail: true, // nullable, defaults to true
  supports_difficulty_scaling: true,
  credits: ["Sandveech", "Jet", "Hibari", "Elle", "Dar", "Akio", "Kio", "Ari", "Ishigami", "Ren", "Minty"],
  date_added:{
  	day : 10,
  	month : 8,
  	year : 2024
  },
	is_enabled: true,
	supports_html: true,
	allow_subpixels: true,
	supports_pi: true,
	show_on_website: true,
	description: ["Make a bergur for yummy in your tummy."],
	how_to_play: ["WASD to move the arm. Press B to grab. Press A to drop item."]
});
