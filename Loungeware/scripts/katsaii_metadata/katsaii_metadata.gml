microgame_register("katsaii_witchcraft", {
    config_version : 1,
    game_name : "Witchcraft",
    authors :  {
        katsaii: "Katsaii",
        mashmerlow: "Mashmerlow"
    },
    prompt : "CRAFT",
    init_room : katsaii_witchcraft_rm,
    view_width : 1,
    view_height : 1,
    time_seconds : 7,
    music_track : katsaii_witchcraft_mu,
    music_loops : false,
    interpolation_on : true,
    cartridge_col_primary : [198, 119, 95],
    cartridge_col_secondary : [238, 199, 138],
    cartridge_label : katsaii_witchcraft_label,
    default_is_fail : true,
    supports_difficulty_scaling : true,
    credits : ["Katsaii", "Mashmerlow"],
    date_added : {
        day : 9,
        month : "July",
        year : 2021
    },
    is_enabled: true,
    supports_html: true,
    show_on_website: true,
    description: [
        "Okay, so basically you're a witch and you craft wands. Thats why the game is called Witchcraft. Okay submit that. No. Stop writing down what I'm saying. Just use the first bit. -- SPEECH-TO-TEXT --"
    ],
    how_to_play: [
        "Use the primary keys to select the highlighted items in order. Missing an item results in a game-over, so be careful. The arrow keys can be used to change the direction of the hand in order to save some time.",
    ],
});

microgame_register("katsaii_witchwanda", {
    config_version : 1,
    game_name : "Witch Wanda",
    authors :  {
        katsaii: "Katsaii",
        mashmerlow: "Mashmerlow"
    },
    prompt : "SHOOT",
    init_room : katsaii_witchwanda_rm_game,
    view_width : -1,
    view_height : -1,
    time_seconds : 12,
    music_track : noone,
    music_loops : false,
    interpolation_on : false,
    cartridge_col_primary : [225, 190, 188],
    cartridge_col_secondary : [255, 238, 234],
    cartridge_label : katsaii_witchwanda_label,
    default_is_fail : true,
    supports_difficulty_scaling : true,
    credits : ["Katsaii", "Mashmerlow"],
    date_added : {
        day : 25,
        month : "August",
        year : 2021
    },
    is_enabled: true,
    supports_html: true,
    show_on_website: true,
    description: [
        "You play as Wanda, a friendly witch flying through the sky amongst clouds and floating islands. Suddenly, a group of witches start to attack Wanda and her island. Defeat the wave of witches and protect the island!"
    ],
    how_to_play: [
        "Use the primary keys to file bullets at opposing witches. Holding down continuous fire will decrease the rate of fire over time, so try to fire in bursts. Use the arrow keys to move around and avoid the projectiles.",
    ],
});