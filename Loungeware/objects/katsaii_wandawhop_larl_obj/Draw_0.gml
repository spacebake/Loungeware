draw_self();

var angle = racketSign * 20;
draw_sprite_ext(
    katsaii_wandawhop_racket, 0,
    x + racketOffset, y - 30, 0.25, 0.25,
    angle, c_white, 1
);