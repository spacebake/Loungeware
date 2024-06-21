microgame_register("mantaray_pool_dive", {
    config_version: 1,
    game_name: "Pool Dive",
    authors : "manta ray",
    prompt: "DIVE!",
    init_room: mantaray_pool_dive_room_Game,
    view_width: 240,
    view_height: 160,
    time_seconds: 5,
    music_track: noone, // nullable, defaults to noone. Accepts: sound name or false
    music_loops: true, // nullable, defaults to true
    interpolation_on: false,
    cartridge_col_primary: [95, 205, 228],
    cartridge_col_secondary: [63, 63, 116],
    cartridge_label: mantaray_pool_dive_spr_Cartridge_Label,
    default_is_fail: true, // nullable, defaults to true
    supports_difficulty_scaling: true,
    credits: ["manta ray", "freesound.org"],
    date_added:{
	  day : 31,
	  month : 5,
	  year : 2022
	},
	is_enabled: true,
	supports_html: true,
	show_on_website: true,
	allow_subpixels: false,
	supports_pi: true,
	show_on_website: true,
	description: ["Attempt a dive from the heights into a small, moving pool!"],
	how_to_play: ["Adjust the angle with left-right and the jump velocity with up-down. Dive with the primary button!"]
});
