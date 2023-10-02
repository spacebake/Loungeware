var squishx = lerp(0.75, 1, bounce);
var squishy = lerp(1.25, 1, bounce);
var scale = serve + 0.25;

draw_sprite_ext(
    sprite_index, image_index,
    x, y, squishx * scale, squishy * scale, angle,
    c_white, 1
);

if (crashed) {
    draw_sprite_ext(
        katsaii_wandawhop_wanda_crack, 0,
        x, y, 1, 1, 0,
        c_white, 1
    );
} else if (showTarget) {
    draw_sprite_ext(
        katsaii_wandawhop_target, 0,
        targetX, targetY, 1, 1, 0,
        c_white, 1 - 2 * serve
    );
}