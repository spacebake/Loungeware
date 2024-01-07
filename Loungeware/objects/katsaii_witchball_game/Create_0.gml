theme = choose(0, 1);
timer = 0;

hasMimpNet = choose(true, false);
hasLilGhost = choose(true, false);
hasAntony = choose(true, false);

larlState = 0;
larlDirection = choose(-1, 1);

var specialBall = choose(true, false);
if (specialBall) {
    ball = choose(1, 2, 3);
} else {
    ball = 0;
}

ballAppearTime = choose(100, 150, 200);
ballImpactSpeed = 0.025;
ballPosition = -1;

var yoko = choose(true, false);
if (yoko) {
    wanda = 3;
} else {
    wanda = choose(0, 1, 2);
}

wandaState = 0;
wandaDirection = choose(-1, 1);

wandaDiveTime = -1;