var oldTimer = timer;
timer += 1;

if (timer < 40) {
    larlState = 0;
} else if (timer < 50) {
    larlState = 1;
} else {
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
    ballPosition += ballImpactSpeed;
}

if (wandaState == 0) {
    var dir = KEY_RIGHT - KEY_LEFT;
    if (dir != 0) {
        wandaDirection = dir;
        wandaDiveTime = 25;
        wandaState = 1;
    }
}

if (wandaState == 1) {
    if (ballPosition < 1 && ballPosition > 0.8 && ballImpactSpeed > 0) {
        microgame_win();
        ballImpactSpeed *= -1;
    }

    wandaDiveTime -= 1;
    if (wandaDiveTime <= 0) {
        wandaState = 2;
    }
}