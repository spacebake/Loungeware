/// @desc Create leaf particles from trees.
var img = floor(image_index);
var wind_angle = 30;
var wind_pitch = 40;
if (img == 3 || img == 2) {
    if (random(1) < 0.01) {
        with (katsaii_wandaring_instance_create_particle(
                x + random(25) * choose(1, -1),
                y + random(25) * choose(1, -1),
                z - 75 + random(25) * choose(1, -1),
                0.1, wind_angle, wind_pitch)) {
            sprite_index = katsaii_wandaring_spr_leaf;
            image_speed = random_range(0.1, 0.5);
            image_blend = other.image_blend;
            wobble = 0.005;
            wobbleSpeed = 10;
            lifetime = 5;
        }
    }
}