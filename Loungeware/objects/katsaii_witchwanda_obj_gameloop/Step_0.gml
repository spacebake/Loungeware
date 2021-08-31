/// @desc Update timers.
//if (keyboard_check_pressed(vk_escape)) {
    //event_user(0);
    //exit;
//}
microgame_sfx_set_gain(musicSound, clamp(musicFade * 0.09, 0, 1), 0);
log(audio_sound_get_gain(musicSound));
if (fadeIn < 1) {
    fadeIn += fadeInCounter;
    if (fadeIn > 1) {
        fadeIn = 1;
    }
}
if ((gameWon || gameOver) && alarm[0] == -1) {
    alarm[0] = 60 * (gameWon ? 2 : 5);
}
if (gameWon) {
    with (katsaii_witchwanda_obj_wanda) {
        instance_create_layer(x, y, layer, katsaii_witchwanda_obj_wanda_essence);
    }
    exit;
}
if (gameOver) {
    global.jamHp = 0;
    if (false) { //gameRestart) {
        gameRestartTimer -= gameRestartCounter;
        if (gameRestartTimer < -0.25) {
            event_user(0);
        }
    } else {
        if (fadeOut >= 1) {
            fadeOut = 1;
            /*if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(ord("X"))) {
                gameRestart = true;
            }*/
        } else {
            fadeOut += fadeOutCounter;
            if (fadeOut >= 1) {
                fadeOut = 1;
            }
        }
    }
    microgame_sfx_set_gain(gameOverSound, fadeOut * max(gameRestartTimer, 0) * 0.18, 0);
    microgame_sfx_set_gain(crumbleSound, 1 - fadeOut, 0);
    musicFade -= musicFadeCounter * 3;
    if (musicFade < 0) {
        musicFade = 0;
    }
    exit;
} else {
    var prev_music = musicFade;
    musicFade += musicFadeCounter * 0.5;
    if (musicFade > 1) {
        musicFade = 1;
    }
}
var before_threshold = global.jamDifficulty < difficultyThreshold;
global.jamDifficulty += difficultyGain;
if (global.jamDifficulty >= difficultyThreshold && before_threshold) {
    difficultyLevel += 4;
    var difficulty_count = array_length(difficultyLevels);
    if (difficultyLevel < difficulty_count) {
        difficultyThreshold += difficultyLevels[difficultyLevel + 0];
        var current_max_diff = global.jamMaxDifficultyLevel;
        var i;
        for (i = 0; i < difficulty_count; i += 4) {
            if (difficultyLevels[i + 2] == current_max_diff) {
                break;
            }
        }
        if (difficultyLevel > i) {
            global.jamMaxDifficultyLevel = difficultyLevels[difficultyLevel + 2];
            //("new top difficulty");
        }
        //("passed difficulty " + string(difficultyLevels[difficultyLevel + 2]));
    } else {
        // reached the max difficulty
    }
}
global.jamHp -= hpDrain;
var prev_pool = global.jamHpPool;
global.jamHpPool = max(0, global.jamHpPool - hpRecover);
global.jamHp += prev_pool - global.jamHpPool;
if (global.jamHp > hpMax) {
    global.jamHp = hpMax;
}
if (global.jamHp < 0) {
    global.jamHp = 0;
    gameOver = true;
} else {
    microgame_sfx_set_gain(crumbleSound, (10 - global.jamHp) / 5, 0);
}
if (!instance_exists(katsaii_witchwanda_obj_enemy)) {
    if (spawnWave) {
        spawnWave = false;
    } else {
        microgame_win();
        gameWon = true;
        var s = sfx_play(katsaii_witchwanda_cheer, 1, false);
        audio_sound_pitch(s, random_range(0.7, 0.9));
        exit;
    }
    //show_debug_message("starting a new wave");
    // types of wave:
    // - single centre enemy
    // - two enemties going in circles
    // - three enemies in a triangle formation, the middle enemy in front
    // - enemy circling another enemy
    ds_list_shuffle(waveStates);
    var wave_50_percent_chance_point = 20;
    var combine_wave_chance = arctan(max(0, global.jamDifficulty) / wave_50_percent_chance_point) * 2 / pi;
    //show_debug_message(combine_wave_chance);
    var x_pad = 20;
    var x_back = KATSAII_WITCH_WANDA_VIEW_RIGHT - x_pad;
    var x_mid = x_back - x_pad;
    var x_front = x_mid - x_pad;
    var x_very_front = x_front - x_pad;
    var y_pad = 20;
    var y_top = KATSAII_WITCH_WANDA_VIEW_TOP + y_pad;
    var y_bottom = KATSAII_WITCH_WANDA_VIEW_BOTTOM - y_pad;
    var y_mid = mean(y_top, y_bottom);
    var wave_chance = 1;
    var active_enemy_health = 0;
    for (var i = ds_list_size(waveStates) - 1; active_enemy_health < 30 && i >= 0; i -= 1) {
        var rand = random(1);
        if (rand > wave_chance) {
            continue;
        }
        wave_chance *= combine_wave_chance;
        var enemy = noone;
        switch (waveStates[| i]) {
        case 0:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_mid, 5, 5);
            break;
        case 1:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_mid, x_pad, x_pad);
            break;
        case 2:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_top + x_pad, 5, 5);
            break;
        case 3:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_top + x_pad, x_pad, x_pad);
            break;
        case 4:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_bottom - x_pad, 5, 5);
            break;
        case 5:
            enemy = katsaii_witchwanda_spawn_enemy(x_front, y_bottom - x_pad, x_pad, x_pad);
            break;
        case 6:
            enemy = katsaii_witchwanda_spawn_enemy(x_back, y_mid, 5, KATSAII_WITCH_WANDA_VIEW_HEIGHT / 2 - y_pad * 4);
            break;
        case 7:
            enemy = katsaii_witchwanda_spawn_enemy(x_mid, lerp(y_top + x_pad, y_mid, 0.5), 5, y_pad);
            break;
        case 8:
            enemy = katsaii_witchwanda_spawn_enemy(x_mid, lerp(y_bottom - x_pad, y_mid, 0.5), 5, y_pad);
            break;
        case 9:
            enemy = katsaii_witchwanda_spawn_enemy(x_very_front, lerp(y_top + x_pad, y_mid, 0.5), x_pad, 5);
            break;
        case 10:
            enemy = katsaii_witchwanda_spawn_enemy(x_very_front, lerp(y_bottom - x_pad, y_mid, 0.5), x_pad, 5);
            break;
        case 11:
            enemy = katsaii_witchwanda_spawn_enemy(x_back, y_top + y_pad, 5, 5);
            break;
        case 12:
            enemy = katsaii_witchwanda_spawn_enemy(x_back, y_bottom - y_pad, 5, 5);
            break;
        }
        if (enemy != noone) {
            active_enemy_health += enemy.hp;
        }
    }
}