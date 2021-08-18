microgame_register("katsaii_witchwanda", {
    config_version : 1,
    game_name : "Witch Wanda",
    creator_name : "Katsaii & Mashmerlow",
    prompt : "CRAFT",
    init_room : katsaii_witchwanda_rm,
    view_width : 1,
    view_height : 1,
    time_seconds : 7,
    music_track : katsaii_witchwanda_mu,
    music_loops : false,
    interpolation_on : true,
    cartridge_col_primary : [198, 119, 95],
    cartridge_col_secondary : [238, 199, 138],
    cartridge_label : katsaii_witchwanda_label,
    default_is_fail : true,
    supports_difficulty_scaling : true,
    credits : ["Katsaii", "Mashmerlow"],
    date_added : {
        day : 9,
        month : "July",
        year : 2021
    },
});