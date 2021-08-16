microgame_register("n8fl_adminsim", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "GM Admin Simulator",
    creator_name: "net8floz",
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
    date_added: "21/07/09"
});

microgame_register("n8fl_cheat_seat", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "Cheat Seat",
    creator_name: "net8floz",
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
    is_enabled: false
});

microgame_register("n8fl_escape1", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
	config_version: 1,
    game_name: "Action Escape Pt 1",
    creator_name : "net8floz",
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
    date_added: "21/07/07"
});

microgame_register("n8fl_escape2", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
    config_version: 1,
    game_name: "Action Escape Pt 2",
    creator_name : "net8floz",
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
    date_added: "21/07/07"
});

microgame_register("n8fl_escape3", {
    // sound fx : https://mixkit.co/free-sound-effects/hit/
    game_name: "Action Escape Pt 3",
    creator_name : "net8floz",
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
    is_enabled: false
});

microgame_register("n8fl_penguin_blast", {
    config_version : 1,
    game_name: "Penguin Blast",
    creator_name : "net8floz",
    prompt: "Don't Get Blasted",
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
    date_added: "21/07/05"
});

microgame_register("n8fl_reach_for_it_mister", {
  config_version: 1,
  game_name: "Reach For It, Mister",
  creator_name : "net8floz",
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
  credits: ["net8floz", "meseta", "space"],
  date_added: "21/07/05"
});