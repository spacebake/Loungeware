if (craftAnimation != -1) {
    var last_step = craftAnimation;
    craftAnimation += craftSpeed;
    if (craftAnimation > 2) {
        craftAnimation = -1;
    } else {
        if (last_step < 1 && craftAnimation > 1) {
            selectionAmount = random(1);
            selectionSpeed *= choose(1, -1);
        }
        exit;
    }
}
if (failed || win) {
    exit;
}
var next_selection = selectionAmount + selectionSpeed;
if (next_selection > 1 || next_selection < 0 || KEY_SECONDARY_PRESSED) {
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
if (KEY_PRIMARY_PRESSED) {
    if (wandCurrent == wandOrder[selectionID]) {
        wandCurrent += 1;
        if (wandCurrent > 2) {
            microgame_win();
            win = true;
            audio_emitter_pitch(resultAudio, random_range(0.9, 1));
            audio_play_sound_on(resultAudio, katsaii_witchwanda_cheer, false, 1);
        } else {
            audio_emitter_pitch(resultAudio, random_range(0.8, 1.2));
            audio_play_sound_on(resultAudio, katsaii_witchwanda_good, false, 1);
        }
        craftAnimation = 0;
    } else {
        microgame_fail();
        microgame_music_stop(0.5);
        audio_emitter_pitch(resultAudio, random_range(0.8, 1.1));
        audio_play_sound_on(resultAudio, katsaii_witchwanda_bad, false, 1);
        failed = true;
    }
}