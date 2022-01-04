if (craftAnimation != -1) {
    var last_step = craftAnimation;
    craftAnimation += craftSpeed;
    if (craftAnimation > 2) {
        craftAnimation = -1;
    } else {
        if (last_step < 1 && craftAnimation > 1) {
            selectionAmount = random_range(0.2, 0.8);
            selectionSpeed *= choose(1, -1);
            wandCurrent += 1;
        }
        exit;
    }
}
if (failed || win) {
    if (resultTimer < 1) {
        resultTimer += resultSpeed;
        if (resultTimer > 1) {
            resultTimer = 1;
        }
    }
    exit;
}
if (KEY_LEFT_PRESSED) {
    selectionSpeed = -abs(selectionSpeed);
}
if (KEY_RIGHT_PRESSED) {
    selectionSpeed = abs(selectionSpeed);
}
var next_selection = selectionAmount + selectionSpeed;
if (next_selection > 1 || next_selection < 0) {
    selectionSpeed *= -1;
} else {
    selectionAmount = next_selection;
}
if (selectionAmount < 1 / 3) {
    selectionID = 0;
} else if (selectionAmount > 2 / 3) {
    selectionID = 2;
} else {
    selectionID = 1;
}
if (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
    if (wandCurrent == wandOrder[selectionID]) {
        if (wandCurrent >= 2) {
            microgame_win();
            win = true;
            var s = sfx_play(katsaii_witchcraft_cheer, 0.5, false);
            audio_sound_pitch(s, random_range(0.9, 1));
        } else {
            var s = sfx_play(katsaii_witchcraft_good, 0.7, false);
            audio_sound_pitch(s, random_range(0.8, 1.2));
        }
        craftAnimation = 0;
    } else {
        failed = true;
    }
}
if (failed || win) {
    alarm[1] = 150;
}
if (TIME_REMAINING < 2 * game_get_speed(gamespeed_fps)) {
    failed = true;
}
if (failed) {
    microgame_fail();
    microgame_music_stop(0.5);
    var s = sfx_play(katsaii_witchcraft_bad, 0.75, false);
    audio_sound_pitch(s, random_range(0.8, 1.1));
}