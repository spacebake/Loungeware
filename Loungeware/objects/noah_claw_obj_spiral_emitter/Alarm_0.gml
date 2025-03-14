

instance_create_layer(x, y, "Bullets", noah_claw_obj_bullet_spiral, {shoot_dir: direction, shoot_speed: bullet_speed});
alarm_set(0, frames_per_bullet);



