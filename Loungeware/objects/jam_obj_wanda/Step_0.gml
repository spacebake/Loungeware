/// @desc Update movement.
part_system_update(partSys);
var xdir = clamp(jam_keyboard_direction(vk_left, vk_right) + jam_keyboard_direction(ord("A"), ord("D")), -1, 1);
var ydir = clamp(jam_keyboard_direction(vk_up, vk_down) + jam_keyboard_direction(ord("W"), ord("S")), -1, 1);
xspeed = jam_movement_iterate(xspeed, acc, frict, handling, xdir);
yspeed = jam_movement_iterate(yspeed, acc, frict, handling, ydir);
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
    audio_emitter_gain(hurtEmitter, 2);
    audio_play_sound_on(hurtEmitter, jam_snd_pop, false, 1);
}
if (y < cam_top || y > cam_bottom) {
    yspeed = (y < cam_top ? 1 : -1) * wall_knockback;
    y = clamp(y, cam_top, cam_bottom);
    audio_emitter_gain(hurtEmitter, 2);
    audio_play_sound_on(hurtEmitter, jam_snd_pop, false, 1);
}
jam_wanda_spawn_particles(partSys);
blast = keyboard_check(ord("X")) || keyboard_check(vk_enter);
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
        audio_emitter_gain(shootEmitter, random_range(0.5, 0.6));
        audio_emitter_pitch(shootEmitter, random_range(0.8, 1.2));
        audio_play_sound_on(shootEmitter, jam_snd_wanda_shoot, false, 1);
        with (instance_create_depth(x, y - 10 + random_range(-5, 5), depth, jam_obj_wanda_projectile)) {
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
var proj = instance_place(x, y, jam_obj_enemy_projectile);
if (hitTimer <= 0) {
    if (proj) {
        instance_destroy(proj);
        hitTimer = 1;
        instance_create_layer(x, y, layer, jam_obj_wanda_essence);
        audio_emitter_pitch(hurtEmitter, 0.8);
        audio_play_sound_on(hurtEmitter, jam_snd_hit, false, 1);
    }
} else if (proj) {
    instance_destroy(proj);
}
var velocity = jam_map_range(point_distance(0, 0, xspeed, yspeed), 0, 20, 0, 1);
audio_emitter_gain(flyEmitter, lerp(0.1, 1, velocity) * 0.5);
audio_emitter_pitch(flyEmitter, lerp(0.75, 1.4, velocity));