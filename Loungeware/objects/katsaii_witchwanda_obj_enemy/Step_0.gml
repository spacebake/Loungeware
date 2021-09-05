/// @desc Update enemy position.
part_system_update(partSys);
entryTimer += entryCounter;
if (entryTimer > 1) {
    entryTimer = 1;
}
hitTimer -= hitCounter;
if (hitTimer < 0) {
    hitTimer = 0;
}
if (lifeTimer < 1) {
    lifeTimer += lifeCounter;
    if (lifeTimer >= 1) {
        exitTimer = 0;
    }
}
if (exitTimer != -1) {
    exitTimer += exitCounter;
    if (exitTimer >= 1) {
        instance_destroy();
        exit;
    }
}
if (entryTimer >= 1) {
    var blast_speed_multiplier = 1;
    switch (bulletId) {
    case 1:
        blast_speed_multiplier = 7;
        break;
    case 2:
        blast_speed_multiplier = 2.5;
        break;
    case 3:
        blast_speed_multiplier = 1;
        break;
    }
    blastTimer -= blastCounter * blast_speed_multiplier;
    if (blastTimer < 0 && global.jamHp > 0) {
        blastTimer = 1;
        // spawn projectiles
        var angless = [[-100, -50, 0, 50, 100], [-60, -20, 20, 60], [-80, -40, 0, 40, 80]];
        var angles = angless[bulletId - 1];
        for (var i = array_length(angles) - 1; i >= 0; i -= 1) {
            var projectile = random(1) < 0.1 ? katsaii_witchwanda_obj_enemy_projectile_fake : katsaii_witchwanda_obj_enemy_projectile;
            var bullet_direction = angles[i];
            with (instance_create_layer(x, y - 10, layer, projectile)) {
                sprite_index = other.bullet;
                speed = 2.5;
                direction = 180 + bullet_direction;
                image_xscale = 1.5;
                image_yscale = 1.5;
            }
        }
    }
}
var interp = katsaii_witchwanda_easein(entryTimer - (exitTimer == -1 ? 0 : exitTimer));
angle += angleSpeed;
var path_x = targetX + lengthdir_x(amplitudeX, angle);
var path_y = targetY + lengthdir_y(amplitudeY, angle);
x = lerp(KATSAII_WITCH_WANDA_VIEW_RIGHT + 50, path_x, interp);
y = lerp(targetY, path_y, interp);
xspeed = x - xprevious;
yspeed = y - yprevious;
katsaii_witchwanda_wanda_enemy_spawn_particles(partSys);
var proj = instance_place(x, y, katsaii_witchwanda_obj_wanda_projectile);
if (proj) {
    // reset life timer whilst actively in combat
    lifeTimer = 0;
}
if (hitTimer <= 0 && entryTimer >= 1) {
    if (hp <= 0) {
        repeat (choose(2, 3, 4)) {
            instance_create_layer(x, y, layer, katsaii_witchwanda_obj_enemy_essence);
        }
        if (global.jamHp <= 0) {
            instance_create_layer(x, y, layer, katsaii_witchwanda_obj_enemy_brutality);
        }
        instance_destroy();
    } else {
        if (proj) {
            instance_destroy(proj);
            hitTimer = 1;
            var hp_loss = 1;
            var crit_distance = 80;
            if (instance_exists(katsaii_witchwanda_obj_wanda) && distance_to_object(katsaii_witchwanda_obj_wanda) < crit_distance) {
                instance_create_layer(x, y, layer, katsaii_witchwanda_obj_enemy_crit);
                hp_loss += 1;
            }
            hp -= hp_loss;
            repeat (hp_loss) {
                instance_create_layer(x, y, layer, katsaii_witchwanda_obj_enemy_essence);
            }
            var s_id = hp > 0 ? katsaii_witchwanda_snd_hit : katsaii_witchwanda_snd_enemy_defeat;
            var s = sfx_play(s_id, hp > 0 ? 0.25 : random_range(0.6, 0.7), false);
            audio_sound_pitch(s, random_range(0.8, 1.2));
        }
    }
} else if (proj) {
    instance_destroy(proj);
}