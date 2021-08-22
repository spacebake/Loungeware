export const games = [
  {
    name: 'katsaii_witchwanda',
    config: {
      config_version: 1,
      game_name: 'Witch Wanda',
      creator_name: 'Katsaii & Mashmerlow',
      prompt: 'CRAFT',
      init_room: 'katsaii_witchwanda_rm',
      view_width: 1,
      view_height: 1,
      time_seconds: 7,
      music_track: 'katsaii_witchwanda_mu',
      music_loops: false,
      interpolation_on: true,
      cartridge_col_primary: [198, 119, 95],
      cartridge_col_secondary: [238, 199, 138],
      cartridge_label: 'katsaii_witchwanda_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['Katsaii', 'Mashmerlow'],
      date_added: {
        day: 9,
        month: 'July',
        year: 2021,
      },
    },
    author_slug: 'katsaii',
    game_slug: 'witchwanda',
  },
  {
    name: 'makoren_conjurer',
    config: {
      config_version: 1,
      game_name: 'Conjurer',
      creator_name: 'Makoren',
      prompt: 'MATCH',
      init_room: 'makoren_conjurer_rm_main',
      view_width: 120,
      view_height: 80,
      time_seconds: 8,
      music_track: 'sng_ennway_bit_battle',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [153, 102, 255],
      cartridge_col_secondary: [69, 41, 95],
      cartridge_label: 'makoren_conjurer_label',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['Makoren'],
      date_added: '21/07/10',
    },
    author_slug: 'makoren',
    game_slug: 'conjurer',
  },
  {
    name: 'kilomatter_jaywalker',
    config: {
      config_version: 1,
      game_name: 'Jay Walker',
      creator_name: 'Kilomatter',
      prompt: 'CROSS',
      init_room: 'kilo_jaywalker_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 6,
      music_track: 'sng_zandy_doctor',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [164, 70, 89],
      cartridge_col_secondary: [123, 23, 62],
      cartridge_label: 'kilo_jaywalker_sprCartLabel',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['Kilomatter', 'Zandy'],
      date_added: '21/08/17',
      is_enabled: true,
    },
    author_slug: 'kilomatter',
    game_slug: 'jaywalker',
  },
  {
    name: 'space_rocket_lander',
    config: {
      config_version: 1,
      game_name: 'Rocket Lander',
      creator_name: 'Space',
      prompt: 'LAND',
      init_room: 'space_lander_rm_lander',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'space_lander_sng_zandy_aliens_edit',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [0, 214, 179],
      cartridge_col_secondary: [0, 125, 150],
      cartridge_label: 'space_lander_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['space'],
      date_added: '21/07/04',
    },
    author_slug: 'space',
    game_slug: 'rocket-lander',
  },
  {
    name: 'space_scooter',
    config: {
      config_version: 1,
      game_name: 'Rixel Rider',
      creator_name: 'Space',
      prompt: 'Backflip',
      init_room: 'space_scoot_rm',
      view_width: 120,
      view_height: 80,
      time_seconds: 6,
      music_track: 'space_scooter_sng_meseta_midnight_drive',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [180, 92, 117],
      cartridge_col_secondary: [43, 36, 56],
      cartridge_label: 'space_scooter_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['space', 'meseta', 'freesound.org', 'zapsplat.com'],
      date_added: '21/07/12',
      is_enabled: true,
    },
    author_slug: 'space',
    game_slug: 'scooter',
  },
  {
    name: 'username_gamename',
    config: {
      config_version: 1,
      game_name: 'EXAMPLE',
      creator_name: 'john doe',
      prompt: 'PRESS',
      init_room: 'username_gamename_rm_game',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'username_gamename_bgm_game',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [0, 0, 0],
      cartridge_col_secondary: [55, 255, 255],
      cartridge_label: 'username_gamename_spr_cartridge',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['john doe', 'jane doe'],
      date_added: {
        day: 17,
        month: 8,
        year: 2021,
      },
      is_enabled: false,
    },
    author_slug: 'username',
    game_slug: 'gamename',
  },
  {
    name: 'yosi_epic_fire_truck',
    config: {
      config_version: 1,
      game_name: 'Epic Fire Truck',
      creator_name: 'Yosi',
      prompt: 'MASH',
      init_room: 'yosi_EFT_rm_init',
      view_width: 240,
      view_height: 160,
      time_seconds: 10,
      music_track: 'yosi_EFT_song',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [255, 50, 50],
      cartridge_col_secondary: [50, 50, 255],
      cartridge_label: 'yosi_EFT_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['yosi'],
      date_added: '21/07/08',
    },
    author_slug: 'yosi',
    game_slug: 'epic-fire-truck',
  },
  {
    name: 'n8fl_escape1',
    config: {
      config_version: 1,
      game_name: 'Action Escape Pt 1',
      creator_name: 'net8floz',
      prompt: 'Jump On The Car',
      init_room: 'n8fl_escape1_rm',
      view_width: 120,
      view_height: 80,
      time_seconds: 5,
      music_track: 'n8fl_escape1_music',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [89, 62, 71],
      cartridge_col_secondary: [122, 88, 89],
      cartridge_label: 'n8fl_escape1_label',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['net8floz', 'meseta', 'space', 'mixkit.c'],
      date_added: '21/07/07',
      is_enabled: false,
      is_hidden: false,
    },
    author_slug: 'n8fl',
    game_slug: 'escape1',
  },
  {
    name: 'n8fl_escape2',
    config: {
      config_version: 1,
      game_name: 'Action Escape Pt 2',
      creator_name: 'net8floz',
      prompt: 'Jump On The Train',
      init_room: 'n8fl_escape2_rm',
      view_width: 120,
      view_height: 80,
      time_seconds: 5,
      music_track: 'n8fl_escape1_music',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [89, 62, 71],
      cartridge_col_secondary: [122, 88, 89],
      cartridge_label: 'n8fl_escape2_label',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['net8floz', 'meseta', 'space', 'mixkit.c'],
      date_added: '21/07/07',
      is_enabled: false,
      is_hidden: false,
    },
    author_slug: 'n8fl',
    game_slug: 'escape2',
  },
  {
    name: 'n8fl_penguin_blast',
    config: {
      config_version: 1,
      game_version: 1,
      game_version_date: {
        day: 21,
        month: 'July',
        year: 2021,
      },
      date_added: '21/07/05',
      game_name: 'Penguin Blast',
      creator_name: 'net8floz',
      prompt: "Don't Get Blasted",
      init_room: 'n8fl_penguin_blast_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 10,
      music_track: 'sng_zandy_woodblocks',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [98, 98, 118],
      cartridge_col_secondary: [28, 22, 51],
      cartridge_label: 'n8fl_penguin_blast_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['net8floz'],
      is_enabled: false,
      is_hidden: false,
      description: [
        'The rad crew are at it again. But this time with cowboy hats.',
      ],
      how_to_play: [
        "You can play the game in many ways but only one way is the correct way. I don't want to give away the ending though",
        'This is the test of a second paragraph',
      ],
      author_id: 'n8fl',
    },
    author_slug: 'n8fl',
    game_slug: 'penguin-blast',
  },
  {
    name: 'n8fl_reach_for_it_mister',
    config: {
      config_version: 1,
      game_version: 1,
      game_version_date: {
        day: 21,
        month: 'July',
        year: 2021,
      },
      date_added: '21/07/05',
      game_name: 'Reach For It, Mister',
      creator_name: 'net8floz',
      description: [
        'The rad crew are at it again. But this time with cowboy hats.',
      ],
      how_to_play: [
        "You can play the game in many ways but only one way is the correct way. I don't want to give away the ending though",
        'This is the test of a second paragraph',
      ],
      is_hidden: false,
      prompt: 'Wait for it',
      init_room: 'n8fl_reach_for_it_mister_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 8,
      music_track: false,
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [89, 62, 71],
      cartridge_col_secondary: [122, 88, 89],
      cartridge_label: 'n8fl_reach_for_it_mister_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['net8floz', 'meseta', 'space'],
      is_enabled: true,
    },
    author_slug: 'n8fl',
    game_slug: 'reach-for-it-mister',
  },
  {
    name: 'mimpy_dinner_date',
    config: {
      config_version: 1,
      game_name: 'Dinner Date',
      creator_name: 'Mimpy',
      prompt: 'REST',
      init_room: 'mimpy_duckdate_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'mimpy_duckdate_mus_hop',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [76, 33, 33],
      cartridge_col_secondary: [102, 48, 48],
      cartridge_label: 'mimpy_duckdate_label',
      default_is_fail: false,
      supports_difficulty_scaling: false,
      credits: ['Mimpy'],
      date_added: '21/07/09',
    },
    author_slug: 'mimpy',
    game_slug: 'dinner-date',
  },
  {
    name: 'mimpy_fire_alarm',
    config: {
      config_version: 1,
      game_name: 'Fire Alarm',
      creator_name: 'Mimpy',
      prompt: 'DOUSE',
      init_room: 'mimpy_firealarm_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'mimpy_firealarm_emergency',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [200, 64, 28],
      cartridge_col_secondary: [102, 30, 32],
      cartridge_label: 'mimpy_firealarm_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['Mimpy'],
      date_added: '21/07/06',
    },
    author_slug: 'mimpy',
    game_slug: 'fire-alarm',
  },
  {
    name: 'mimpy_objection',
    config: {
      config_version: 1,
      game_name: 'Objection!',
      creator_name: 'Mimpy',
      prompt: 'CONTRADICT',
      init_room: 'mimpy_objection_rm',
      view_width: 720,
      view_height: 480,
      time_seconds: 8,
      music_track: 'sng_ennway_bit_battle',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [94, 116, 204],
      cartridge_col_secondary: [177, 209, 215],
      cartridge_label: 'mimpy_objection_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['Mimpy'],
      date_added: '21/07/06',
    },
    author_slug: 'mimpy',
    game_slug: 'objection',
  },
  {
    name: 'baku_chug',
    config: {
      config_version: 1,
      game_name: 'Forced Choice of a New Generation',
      creator_name: 'baku',
      prompt: 'CHUG',
      init_room: 'baku_chug_rm',
      view_width: 160,
      view_height: 107,
      time_seconds: 7,
      music_track: 'sng_zandy_xylo',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [148, 44, 75],
      cartridge_col_secondary: [98, 23, 72],
      cartridge_label: 'baku_chug_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['baku'],
      date_added: '21/07/08',
    },
    author_slug: 'baku',
    game_slug: 'chug',
  },
  {
    name: 'baku_mine',
    config: {
      config_version: 1,
      game_name: 'Lonesome Miner',
      creator_name: 'baku',
      prompt: [
        'MINE DIAMOND',
        'MINE EMERALD',
        'MINE GOLD',
        'MINE RUBY',
        'MINE IRON',
      ],
      init_room: 'baku_mine_rm',
      view_width: 480,
      view_height: 320,
      time_seconds: 12,
      music_track: 'baku_mine_bgm_minecraft',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [96, 81, 88],
      cartridge_col_secondary: [42, 35, 37],
      cartridge_label: 'baku_mine_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['baku', 'meseta'],
      date_added: '21/07/21',
    },
    author_slug: 'baku',
    game_slug: 'mine',
  },
  {
    name: 'anti_hats',
    config: {
      config_version: 1,
      game_name: 'Hats',
      creator_name: 'Antidissmist',
      prompt: 'SHADES',
      init_room: 'anti_hats_rm_start',
      view_width: 240,
      view_height: 160,
      time_seconds: 4,
      music_track: 'anti_hats_music',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [29, 43, 83],
      cartridge_col_secondary: [126, 37, 83],
      cartridge_label: 'anti_hats_sp_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['Antidissmist'],
      date_added: '21/07/14',
    },
    author_slug: 'anti',
    game_slug: 'hats',
  },
  {
    name: 'tfg_collision',
    config: {
      config_version: 1,
      game_name: 'FIX COLLISION',
      creator_name: 'tfg',
      prompt: 'FIND ERROR',
      init_room: 'tfg_collision_rm_game',
      view_width: 960,
      view_height: 640,
      time_seconds: 9.5,
      music_track: 'sng_ennway_bit_battle',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: '0x121212',
      cartridge_col_secondary: '0x71b8ff',
      cartridge_label: 'tfg_collision_spr_cartridge',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['tfg', 'ennway', 'zandy'],
      date_added: '21/07/09',
    },
    author_slug: 'tfg',
    game_slug: 'collision',
  },
  {
    name: 'tfg_swipe',
    config: {
      config_version: 1,
      game_name: 'SWIPE',
      creator_name: 'tfg',
      prompt: 'SWIPE',
      init_room: 'tfg_swipe_rm_game',
      view_width: -1,
      view_height: -1,
      time_seconds: 5,
      music_track: 'tfg_swipe_bgm_amogus',
      music_loops: false,
      interpolation_on: true,
      cartridge_col_primary: '0x555555',
      cartridge_col_secondary: '0x959595',
      cartridge_label: 'tfg_swipe_spr_cartridge',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['tfg', 'zandy', 'space'],
      date_added: '21/08/15',
      is_enabled: true,
    },
    author_slug: 'tfg',
    game_slug: 'swipe',
  },
  {
    name: 'nahoo_beenade',
    config: {
      config_version: 1,
      game_name: 'Beenade',
      creator_name: 'Nahoo',
      prompt: 'POLLINATE',
      init_room: 'nahoo_beenade_rMain',
      is_enabled: true,
      view_width: 480,
      view_height: 320,
      time_seconds: 5,
      music_track: 'Nahoo_mMain',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [255, 244, 101],
      cartridge_col_secondary: [241, 161, 96],
      cartridge_label: 'Nahoo_beenade_cartridge',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['Nahoo'],
      date_added: '21/07/04',
    },
    author_slug: 'nahoo',
    game_slug: 'beenade',
  },
  {
    name: 'nahoo_carttypebeat',
    config: {
      config_version: 1,
      game_name: 'Cart Type Beat',
      creator_name: 'Nahoo',
      prompt: 'REVOLT',
      init_room: 'nahoo_carttypebeat_rMain',
      view_width: 480,
      view_height: 320,
      time_seconds: 10,
      music_track: 'Nahoo_mMain',
      music_loops: true,
      interpolation_on: false,
      cartridge_col_primary: [75, 38, 128],
      cartridge_col_secondary: [197, 59, 157],
      cartridge_label: 'Nahoo_carttypebeat_cartridge',
      default_is_fail: true,
      supports_difficulty_scaling: false,
      credits: ['Nahoo'],
      date_added: '21/07/12',
      is_enabled: false,
    },
    author_slug: 'nahoo',
    game_slug: 'carttypebeat',
  },
  {
    name: 'jdllama_hammer',
    config: {
      config_version: 1,
      game_name: "THROWIN' THE HAMMER",
      is_enabled: true,
      creator_name: 'J.D. Lowe',
      prompt: 'THROW HAMMER',
      init_room: 'jdllama_hammer_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'noone',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [0, 0, 0],
      cartridge_col_secondary: [131, 147, 202],
      cartridge_label: 'jdllama_hammer_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['J.D. Lowe'],
      date_added: '21/08/12',
    },
    author_slug: 'jdllama',
    game_slug: 'hammer',
  },
  {
    name: 'jdllama_target',
    config: {
      config_version: 1,
      game_name: 'TARGET BREAKING YEAH',
      creator_name: 'J.D. Lowe',
      prompt: 'SHOOT THE TARGETS',
      init_room: 'jdllama_target_rm',
      view_width: 240,
      view_height: 160,
      time_seconds: 5,
      music_track: 'jdllama_target_snd_theme',
      music_loops: false,
      interpolation_on: false,
      cartridge_col_primary: [0, 0, 0],
      cartridge_col_secondary: [55, 255, 255],
      cartridge_label: 'jdllama_target_spr_label',
      default_is_fail: true,
      supports_difficulty_scaling: true,
      credits: ['J.D. Lowe', 'Zandy'],
      date_added: '21/08/09',
    },
    author_slug: 'jdllama',
    game_slug: 'target',
  },
];
export const numGames = 23;
export const numContributors = 22;
