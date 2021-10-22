/// @desc Follow object.
if (random(1) < 0.5) {
    with (katsaii_wandaring_instance_create_particle(x, y, z, 0.5, random(360), random(360))) {
        sprite_index = katsaii_wandaring_spr_sparkle;
        image_speed = 0;
    }
}
// follow object
var trail_distance = 20;
if (follow != noone) {
    var anchor_x = follow.x;
    var anchor_y = follow.y;
    var anchor_z = follow.z;
    if (follow == katsaii_wandaring_obj_wanda) {
        anchor_z -= 10;
    }
    var dist = point_distance_3d(anchor_x, anchor_y, anchor_z, x, y, z);
    if (dist > trail_distance) {
        var scale = trail_distance / dist;
        x = anchor_x + scale * (x - anchor_x);
        y = anchor_y + scale * (y - anchor_y);
        z = anchor_z + scale * (z - anchor_z);
    }
}