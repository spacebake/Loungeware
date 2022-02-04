microgame_register("anti_hats", {
    config_version:					1,
    game_name:						"Hats",
    authors :						"Antidissmist",
    prompt:							"SHADES",
    init_room:						anti_hats_rm_start,
    view_width:						240,
    view_height:					160,
    time_seconds:					4,
    music_track:					anti_hats_music,
    music_loops:					false,
    interpolation_on:				false,
    cartridge_col_primary:			[29,43,83],
    cartridge_col_secondary:		[126,37,83],
    cartridge_label:				anti_hats_sp_label,
    default_is_fail:				true,
    supports_difficulty_scaling:	true,
    credits:						["Antidissmist"],
    date_added:						"21/07/14",
	is_enabled:						true,
	supports_html:					true,
	show_on_website:				true,
	description:					[ "Hats are falling! Don't let them ruin your outfit!" ],
	how_to_play:					[ "Move LEFT and RIGHT to get the shades to fall onto your head" ],
});

microgame_register("anti_dungeon", {
    config_version:					1,
    game_name:						"Dungeon",
    authors :						"Antidissmist",
    prompt:							"FIGHT",
    init_room:						anti_dungeon_rm_start,
    view_width:						120,
    view_height:					80,
    time_seconds:					8,
    //music_track:					false,//anti_dungeon_music,
    //music_loops:					false,
    interpolation_on:				false,
    cartridge_col_primary:			[26,23,33],
    cartridge_col_secondary:		[143,41,85],
    cartridge_label:				anti_dungeon_sp_label,
    default_is_fail:				true,
    supports_difficulty_scaling:	false,
    credits:						[ "Antidissmist", "Space" ],
    date_added:						{ day : 3, month : "February", year : 2022 },
	is_enabled:						true,
	supports_html:					true,
	show_on_website:				true,
	description:					[ "A challenger approaches!" ],
	how_to_play:					[ "Outwit some guys" ],
});