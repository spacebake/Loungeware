microgame_register("space_rocket_lander", {
    config_version: 1,
    game_name: "Rocket Lander",
    authors : "space",
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
    date_added: "21/07/04",
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Land a spaceship on the planet's surface. Be careful though, the ship is fragile.", 
	],
	how_to_play: [
		"Land the ship as slowly as possible to avoid crashing. Press UP to thrust"
	],
});

microgame_register("space_scooter", {
    config_version: 1,
    game_name: "Rixel Rider",
    authors : "space",
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
    is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Cruisin' through the forest at midnight with only bats for company.", 
		"Can you pull off the dopest backflip the world has ever seen?"
	],
	how_to_play: [
		"Pull off a successful backflip by holding LEFT whlile airborne. Try to land as flat as possible!"
	],
});

microgame_register("space_larold_lineup", {
    config_version: 1,
    game_name: "Larold Lineup",
    authors : "space",
    prompt: "Memorize",
    init_room: space_ll_rm_main,
    view_width: 240,
    view_height: 160,
    time_seconds: 12,
    music_track: sng_zandy_persnickety_noloop,
    music_loops: false,
    interpolation_on: false,
    cartridge_col_primary: [205,114,64],
    cartridge_col_secondary: [61,33,39],
    cartridge_label: space_ll_label,
    default_is_fail: true,
    supports_difficulty_scaling: true,
    credits: ["space", "zandy", "baku", "sam", "zapsplat.com", "Dillon Becker"],
    date_added: "21/09/22",
    is_enabled: true,
	supports_html: true,
	show_on_website: true,
	description: [
		"Detective Baku has been called down to the station to identify a very naughty larold."
	],
	how_to_play: [
		"Memorize which Larold is holding which number, then select the correct number once the guilty suspect is revealed."
	],
});

