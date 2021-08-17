// nullable fields may be omitted entirely
// if your game fails validatio, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading
microgame_register("{Kilomatter}_{Jay Walker}", {
    config_version: 1,
    game_name: "Jay Walker",
    creator_name : "Kilomatter",
    prompt: "CROSS",
    init_room: kilo_jaywalker_rm,
    view_width: 240,
    view_height: 160,
    time_seconds: 6,
    music_track: sng_zandy_doctor, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [68, 114, 214],
    cartridge_col_secondary: [47, 103, 170],
    cartridge_label: kilo_jaywalker_sprCartLabel,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: false,
    credits: ["Kilomatter", "Zandy"],
    date_added: "21/8/17",
	is_enabled: true
});