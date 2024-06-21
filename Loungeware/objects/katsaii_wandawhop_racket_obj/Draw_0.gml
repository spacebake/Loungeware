var bounceScale = lerp(0.85, 1, bounce);
var bounceOffset = lerp(-30, 0, bounce);

draw_sprite_ext(
    sprite_index, image_index,
    x, y + bounceOffset,
    bounceScale * image_xscale, bounceScale * image_yscale,
    image_angle, image_blend, image_alpha
);