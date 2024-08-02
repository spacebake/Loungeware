// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config

microgame_register("pixpope_hereticpurge", {
  config_version: 1,
  game_name: "Heretic Purge",
  authors : {pixpope: "Pixelated Pope"},
  prompt: "PURGE HERETICS",
  init_room: pixpope_hp_rm_main,
  view_width: -1,
  view_height: -1,
  time_seconds: 10,
  music_track: pixpope_hp_bgm, // nullable, defaults to noone. Accepts: sound name or false
  music_loops: false, // nullable, defaults to true
  interpolation_on: false,
  cartridge_col_primary: [116, 164, 60],
  cartridge_col_secondary: [71, 136, 23],
  cartridge_label: pixpope_hp_spr_label,
  default_is_fail: true, // nullable, defaults to true
  supports_difficulty_scaling: true,
  credits: ["Pixelated Pope"],
  date_added:{
  	day : 1,
  	month : 8,
  	year : 2024
  },
	is_enabled: true,
	supports_html: true,
	allow_subpixels: true,
	supports_pi: true,
	show_on_website: true,
	description: ["Build up enough holy energy to purge the heretics!"],
	how_to_play: ["Press A and B alternating as quickly as possible!"]
});
