microgame_register("space_rocket_lander", {
    config_version: 1,
    game_name: "Rocket Lander",
    creator_name : "Space",
    prompt: "LAND",
    init_room: space_lander_rm_lander,
    view_width: 240,
    view_height: 160,
    time_seconds: 5,
    music_track: space_lander_sng_zandy_aliens_edit,
    music_loops: false,
    interpolation_on: false,
    cartridge_col_primary: [0, 214, 179],
    cartridge_col_secondary: [0, 125, 150],
    cartridge_label: space_lander_label,
    default_is_fail: true,
    supports_difficulty_scaling: true,
    credits: ["space"],
    date_added: "21/07/04"
});

microgame_register("space_scooter", {
    config_version: 1,
    game_name: "Rixel Rider",
    creator_name : "Space",
    prompt: "Backflip",
    init_room: space_scoot_rm,
    view_width: 120,
    view_height: 80,
    time_seconds: 6,
    music_track: space_scooter_sng_meseta_midnight_drive,
    music_loops: false,
    interpolation_on: false,
    cartridge_col_primary: [180,92,117],
    cartridge_col_secondary: [43,36,56],
    cartridge_label: space_scooter_spr_label,
    default_is_fail: true,
    supports_difficulty_scaling: false,
    credits: ["space", "meseta", "freesound.org", "zapsplat.com"],
    date_added: "21/07/12",
    is_enabled: true
});

