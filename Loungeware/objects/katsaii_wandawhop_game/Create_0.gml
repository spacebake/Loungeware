angle = 0;
alarm[0] = 1;

serveSpeeds = [
    0.02,
    0.025,
    0.03,
    0.031,
    0.032
];

serve = 1;
serveSpeed = serveSpeeds[DIFFICULTY - 1];
currentServeSpeed = -serveSpeed;

bounce = 0;
bounceSpeed = 0.1;

depthMin = -100;
depthMax = -200;
depth = depthMax;

larlX = room_width / 2 + choose(0, -50, 50);
larlY = room_height / 2 + 50 + choose(0, -25, 25);
instance_create_depth(larlX, larlY, depthMin, katsaii_wandawhop_larl_obj);

targetX = 0;
targetY = 0;

getRandomTarget = function () {
    var pad = 150;
    targetX = random_range(pad, room_width - pad);
    targetY = random_range(pad, room_height - pad);
};

getRandomTarget();

x = targetX;
y = targetY;
instance_create_depth(x, y, depthMax, katsaii_wandawhop_racket_obj);

crashed = false;
showTarget = false;

var snd = sfx_play(katsaii_wandawhop_return, 1, false);
audio_sound_pitch(snd, choose(0.9, 1, 1.1));