/// @desc Update movement.
part_system_update(partSys);
var xdir = clamp(KEY_RIGHT - KEY_LEFT, -1, 1);
var ydir = clamp(KEY_DOWN - KEY_UP, -1, 1);
xspeed = katsaii_witchwanda_movement_iterate(xspeed, acc, frict, handling, xdir);
yspeed = katsaii_witchwanda_movement_iterate(yspeed, acc, frict, handling, ydir);
var slow_down = lerp(1, -0.25, hitTimer);
x += xspeed * slow_down;
y += yspeed * slow_down;
var cam = KATSAII_WITCH_WANDA_VIEW_CAM;
var cam_left = camera_get_view_x(cam);
var cam_top = camera_get_view_y(cam);
var cam_right = cam_left + camera_get_view_width(cam);
var cam_bottom = cam_top + camera_get_view_height(cam);
var wall_knockback = 4;
if (x < cam_left || x > cam_right) {
    xspeed = (x < cam_left ? 1 : -1) * wall_knockback;
    x = clamp(x, cam_left, cam_right);
    sfx_play(katsaii_witchwanda_snd_pop, 2, false);
}
if (y < cam_top || y > cam_bottom) {
    yspeed = (y < cam_top ? 1 : -1) * wall_knockback;
    y = clamp(y, cam_top, cam_bottom);
    sfx_play(katsaii_witchwanda_snd_pop, 2, false);
}
katsaii_witchwanda_wanda_spawn_particles(partSys);
blast = KEY_PRIMARY || KEY_SECONDARY;
if (blast) {
    if (blastHeld < 120) {
        blastHeld += 1;
    }
} else if (blastHeld >= 1) {
    blastHeld -= 5;
}
if (blastTimer == -1) {
    if (blast) {
        blastTimer = 1;
        var s = sfx_play(katsaii_witchwanda_snd_wanda_shoot, random_range(0.5, 0.6), false);
        audio_sound_pitch(s, random_range(0.8, 1.2));
        with (instance_create_depth(x, y - 10 + random_range(-5, 5), depth, katsaii_witchwanda_obj_wanda_projectile)) {
            speed = 10;
            //direction = 3 * (other.xspeed + other.yspeed) + random_range(-3, 3);
            hspeed += other.xspeed;
            vspeed += 1.25 * other.yspeed;
            direction += random_range(-5, 5);
            image_angle = direction;
        }
    }
} else {
    var blast_slowdown = (blastHeld + 60) / 60;
    blastTimer -= blastCountdown / blast_slowdown;
    if (blastTimer < 0) {
        blastTimer = -1;
    }
}
hitTimer -= hitCounter;
if (hitTimer < 0) {
    hitTimer = 0;
}
var proj = instance_place(x, y, katsaii_witchwanda_obj_enemy_projectile);
if (hitTimer <= 0) {
    if (proj) {
        instance_destroy(proj);
        hitTimer = 1;
        instance_create_layer(x, y, layer, katsaii_witchwanda_obj_wanda_essence);
        var s = sfx_play(katsaii_witchwanda_snd_hit, 1, false);
        audio_sound_pitch(s, 0.8);
    }
} else if (proj) {
    instance_destroy(proj);
}
var velocity = katsaii_witchwanda_map_range(point_distance(0, 0, xspeed, yspeed), 0, 20, 0, 1);
audio_emitter_gain(flyEmitter, lerp(0.1, 1, velocity) * 0.5);
audio_emitter_pitch(flyEmitter, lerp(0.75, 1.4, velocity));