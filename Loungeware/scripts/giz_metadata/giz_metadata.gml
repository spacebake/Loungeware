// nullable fields may be omitted entirely
// if your game fails validation, for example couldn't find room resource, 
// then your game will not be loaded. Check the Output in GMS2 when booting the game form
// warnings if your game is not loading.

// for help with filling out your metadata see the wiki: 
// https://github.com/spacebake/Loungeware/wiki/Microgame-Config


microgame_register("giz_laronin", {
	
    config_version				: 1,
    game_name					: "Laronin",
    authors						: "Gizmo199",
    prompt						: "PATIENCE",
    init_room					: giz_laronin_rm_main,
    view_width					: 240,
    view_height					: 160,
    time_seconds				: 8,
    music_track					: giz_laronin_snd_ambience, // nullable, defaults to noone. Accepts: sound name or false
    music_loops					: true, // nullable, defaults to true
    interpolation_on			: false,
    cartridge_col_primary		: [200, 85, 78],
    cartridge_col_secondary		: [26, 23, 33],
    cartridge_label				: giz_laronin_spr_label,
    default_is_fail				: true, // nullable, defaults to true
    supports_difficulty_scaling	: true,
    credits						: ["Gizmo199"],
    date_added					: { day : 26, month : 9, year : 2023 },
	is_enabled					: true,
	supports_html				: true,
	show_on_website				: true,
	description					: ["Wait for the '!' signal and press any button as quick as you can to slash your opponent!"],
	how_to_play					: ["Wait for the '!' signal and press any button as quick as you can to slash your opponent!"]

});

microgame_register("giz_face_off", {
	
    config_version				: 1,
    game_name					: "Face Off",
    authors						: "Gizmo199",
    prompt						: "DE-GLOVE",
    init_room					: giz_beast_bullet_rm_main,
    view_width					: 480,
    view_height					: 320,
    time_seconds				: 8,
    music_track					: giz_beast_bullet_theme_music, // nullable, defaults to noone. Accepts: sound name or false
    music_loops					: true, // nullable, defaults to true
    interpolation_on			: false,
    cartridge_col_primary		: [71, 89, 153],
    cartridge_col_secondary		: [0, 214, 179],
    cartridge_label				: giz_beast_bullet_label,
    default_is_fail				: true, // nullable, defaults to true
    supports_difficulty_scaling	: true,
    credits						: ["Gizmo199", "mashmerlow", "Zandy"],
    date_added					: { day : 26, month : 9, year : 2023 },
	is_enabled					: true,
	supports_html				: true,
	show_on_website				: true,
	description					: ["Obliterate Larold before he obliterates you!"],
	how_to_play					: ["Obliterate Larold before he obliterates you!"]

});

microgame_register("giz_speed_demon", {
	
    config_version				: 1,
    game_name					: "Speed Demon",
    authors						: "Gizmo199",
    prompt						: "FASTER!",
    init_room					: giz_speed_demon_rm_main,
    view_width					: 480,
    view_height					: 320,
    time_seconds				: 8,
    music_track					: giz_beast_bullet_theme_music, // nullable, defaults to noone. Accepts: sound name or false
    music_loops					: true, // nullable, defaults to true
    interpolation_on			: false,
    cartridge_col_primary		: [71, 89, 153],
    cartridge_col_secondary		: [0, 214, 179],
    cartridge_label				: giz_beast_bullet_label,
    default_is_fail				: true, // nullable, defaults to true
    supports_difficulty_scaling	: true,
    credits						: ["Gizmo199", "mashmerlow", "Zandy"],
    date_added					: { day : 26, month : 9, year : 2023 },
	is_enabled					: true,
	supports_html				: true,
	show_on_website				: true,
	description					: ["Obliterate Larold before he obliterates you!"],
	how_to_play					: ["Obliterate Larold before he obliterates you!"]

});
