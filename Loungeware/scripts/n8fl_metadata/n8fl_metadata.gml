microgame_register("n8fl_adminsim", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "GM Admin Simulator",
    authors :  { n8fl: "net8floz" },
    prompt: "BAN OR BE BANNED",
    init_room: n8fl_admin_simulator_rm,
    view_width: 240,
    view_height: 160,
    time_seconds: 6,
    music_track: n8fl_admin_simulator_music,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [89, 62, 71],
    cartridge_col_secondary: [122, 88, 89],
    cartridge_label: n8fl_admin_simulator_label,
    default_is_fail: true,
    supports_difficulty_scaling: true,
    credits: ["net8floz", "meseta", "space", "mixkit.c"],
    date_added: "21/07/09",
    is_enabled: false,
	supports_html: false,
	show_on_website: false,
});

microgame_register("n8fl_cheat_seat", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "Cheat Seat",
    authors :  { n8fl: "net8floz" },
    prompt: "Mash To Cheat",
    init_room: n8fl_cheat_seat_rm,
    view_width: 120,
    view_height: 80,
    time_seconds: 6,
    music_track: n8fl_escape1_music,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [89, 62, 71],
    cartridge_col_secondary: [122, 88, 89],
    cartridge_label: n8fl_escape3_label,
    default_is_fail: true,
    supports_difficulty_scaling: false,
    credits: ["net8floz", "meseta", "space", "mixkit.c"],
    date_added: "21/07/07",
    is_enabled: false,
	supports_html: false,
	show_on_website: false,
});

microgame_register("n8fl_escape1", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "Action Escape Pt 1",
    authors :  { n8fl: "net8floz" },
    prompt: "Jump On The Car",
    init_room: n8fl_escape1_rm,
    view_width: 120,
    view_height: 80,
    time_seconds: 5,
    music_track: n8fl_escape1_music,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [89, 62, 71],
    cartridge_col_secondary: [122, 88, 89],
    cartridge_label: n8fl_escape1_label,
    default_is_fail: true,
    supports_difficulty_scaling: false,
    credits: ["net8floz", "meseta", "space", "mixkit.c"],
    date_added: "21/07/07",
    is_enabled: false,
	supports_html: true,
	show_on_website: false,
});

microgame_register("n8fl_escape2", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
    config_version: 1,
    game_name: "Action Escape Pt 2",
    authors :  { n8fl: "net8floz" },
    prompt: "Jump On The Train",
    init_room: n8fl_escape2_rm,
    view_width: 120,
    view_height: 80,
    time_seconds: 5,
    music_track: n8fl_escape1_music,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [89, 62, 71],
    cartridge_col_secondary: [122, 88, 89],
    cartridge_label: n8fl_escape2_label,
    default_is_fail: true,
    supports_difficulty_scaling: false,
    credits: ["net8floz", "meseta", "space", "mixkit.c"],
    date_added: "21/07/07",
    is_enabled: false,
	supports_html: true,
	show_on_website: false,
});

microgame_register("n8fl_escape3", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
    game_name: "Action Escape Pt 3",
    authors :  { n8fl: "net8floz" },
    prompt: "Jump On The Heli",
    init_room: n8fl_escape3_rm,
    view_width: 120,
    view_height: 80,
    time_seconds: 6,
    music_track: n8fl_escape1_music,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [89, 62, 71],
    cartridge_col_secondary: [122, 88, 89],
    cartridge_label: n8fl_escape3_label,
    default_is_fail: true,
    supports_difficulty_scaling: false,
    credits: ["net8floz", "meseta", "space", "mixkit.c"],
    date_added: "21/07/07",
    is_enabled: false,
	supports_html: false,
	show_on_website: false,
});

microgame_register("n8fl_penguin_blast", {
    config_version : 1,
	game_version: 1,
	game_version_date: {
		day: 21,
		month: "July",
		year: 2021
	},
	date_added: {
		day: 21,
		month: "July",
		year: 2021
	},
    game_name: "Penguin Blast",
    authors :  { n8fl: "net8floz" },
    prompt: "HOLD DOWN, HOLD A/B",
    init_room: n8fl_penguin_blast_rm,
    view_width: 240,
    view_height: 160,
    time_seconds: 10,
    music_track: sng_zandy_woodblocks,
    music_loops: true,
    interpolation_on: false,
    cartridge_col_primary: [98, 98, 118],
    cartridge_col_secondary: [28, 22, 51],
    cartridge_label: n8fl_penguin_blast_label,
    default_is_fail: true,
    supports_difficulty_scaling: true,
    credits: ["net8floz"],
    date_added: "21/07/05",
    is_enabled: true,
	description: [
	"The evil orange cat with sunglasses has kidnapped the fair Mimpy Penguin. The only problem? This penguin can't swim."
	],
	how_to_play: ["Use the Primary Key & Secondary key to match the Red and Green projectiles. Use the Down key to block bombs. Match all the projectiles and save the princess."],
	author_id: "n8fl",
	supports_html: true,
	show_on_website: true,
});

microgame_register("n8fl_reach_for_it_mister", {
  config_version: 1,
  
  // for public display
  game_version: 1,
  game_version_date: {
	day: 21,
	month: "July",
	year: 2021
  },
	date_added: {
	day: 21,
	month: "July",
	year: 2021
  },
  game_name: "Reach For It, Mister",
  authors :  { n8fl: "net8floz" },
  description: [
	"The rad crew are at it again. But this time with cowboy hats."
  ],
  how_to_play: ["Match the buttons on screen before your opponent does! Last hat standing."],
  
  prompt: "Wait for it",
  init_room: n8fl_reach_for_it_mister_rm,
  view_width: 240,
  view_height: 160,
  time_seconds: 8,
  music_track: false,
  music_loops: true,
  interpolation_on: false,
  cartridge_col_primary: [89, 62, 71],
  cartridge_col_secondary: [122, 88, 89],
  cartridge_label: n8fl_reach_for_it_mister_label,
  default_is_fail: true,
  supports_difficulty_scaling: true,
  credits: ["nt8floz - game", "meseta - music", "space - art"],
  date_added: "21/07/05",
  supports_html: true,
  show_on_website: true,
});
