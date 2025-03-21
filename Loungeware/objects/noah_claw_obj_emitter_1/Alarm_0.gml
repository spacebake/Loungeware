
if (active)
{
	instance_create_layer(x, y, "Bullets", noah_claw_obj_bullet_straight, {shoot_speed: bullet_speed, shoot_dir: bullet_dir });
}

alarm_set(0, frames_per_shot);