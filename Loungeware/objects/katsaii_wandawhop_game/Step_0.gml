if (crashed) {
    exit;
}

serve += currentServeSpeed;
angle += -2;

if (serve < 0) {
    // larold
    serve = 0;
    currentServeSpeed = serveSpeed * choose(1, 1.1, 0.9);
    getRandomTarget();
    showTarget = true;

    var snd = sfx_play(katsaii_wandawhop_serve, 1, false);
    audio_sound_pitch(snd, choose(0.9, 1, 1.1));

    bounce = 0;

    with (katsaii_wandawhop_larl_obj) {
        racketSign *= -1;
    }
}

if (serve > 1) {
    // player
    var racket = instance_place(x, y, katsaii_wandawhop_racket_obj);
    if (racket != noone) {
        serve = 1;
        currentServeSpeed = -serveSpeed;
        racket.bounce = 0;
        showTarget = false;

        var snd = sfx_play(katsaii_wandawhop_return, 1, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));

        bounce = 0;
    }

    if (serve > 1.25) {
        // wanda is died
        serve = 1.25;
        crashed = true;
        sprite_index = katsaii_wandawhop_wanda_smoosh;
        microgame_fail();

        var snd = sfx_play(katsaii_wandawhop_glass, 0.5, false);
        audio_sound_pitch(snd, choose(0.9, 1, 1.1));

        bounce = 1;

        with (katsaii_wandawhop_larl_obj) {
            racketSign = 0;
        }
    }
}

bounce += bounceSpeed;
if (bounce > 1) {
    bounce = 1;
}

var arc = serve / 1.25; // 1.25 == max value
arc = 4 * arc * (1 - arc);

x = lerp(larlX, targetX, serve);
y = lerp(larlY - 30, targetY, serve) - 200 * arc; // -30 for racket offset
depth = lerp(depthMin, depthMax, serve);