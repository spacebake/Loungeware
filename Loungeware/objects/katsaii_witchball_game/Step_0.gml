var oldTimer = timer;
timer += 1;

if (timer < 40) {
    larlState = 0;
} else if (timer < 50) {
    larlState = 1;
    if (oldTimer <= 40 && timer > 40) {
        var snd = sfx_play(katsaii_witchball_hit, 1, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));
    }
} else if (larlState < 2) {
    var snd = sfx_play(katsaii_witchball_sand, 1, false);
    audio_sound_pitch(snd, choose(0.9, 1, 1.1));
    larlState = 2;
}

if (oldTimer <= ballAppearTime && timer > ballAppearTime) {
    // randomly flip target direction
    if (choose(false, true)) {
        larlDirection *= -1;
    }
    ballPosition = 0;
}

if (ballPosition > -1) {
    if (ballPosition < 1 && ballPosition + ballImpactSpeed >= 1) {
        var snd = sfx_play(katsaii_witchball_sand, 1, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));
    }
    ballPosition += ballImpactSpeed;
}

if (wandaState == 0) {
    var dir = KEY_RIGHT - KEY_LEFT;
    if (dir != 0) {
        var snd = sfx_play(katsaii_witchball_sand, 1, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));
        wandaDirection = dir;
        wandaDiveTime = 25;
        wandaState = 1;
    }
}

if (wandaState == 1) {
    if (!wonGame && ballPosition < 1 && ballPosition > 0.8 && sign(wandaDirection) == sign(larlDirection)) {
        wonGame = true;
        microgame_win();
        var snd = sfx_play(katsaii_witchball_hit, 1, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));
        ballImpactSpeed *= -1;
        larlState = 3;
    }

    wandaDiveTime -= 1;
    if (wandaDiveTime <= 0) {
        wandaState = 2;
        if (!wonGame) {
            sfx_play(katsaii_witchball_fail, 1, false);
        } else {
            var snd = sfx_play(katsaii_witchball_sand, 1, false);
            audio_sound_pitch(snd, choose(0.9, 1, 1.1));
        }
        if (ballPosition < 1) {
            ballInFront = true; // funny ball landing on top of wanda
        }
    }
}