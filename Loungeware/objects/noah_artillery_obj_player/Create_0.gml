/// @description Init Vars

aim_speed = 1;

// projectile start variables
projectile_start_x = x;
projectile_start_y = y;
reticle_x = x;
reticle_y = y;

update_projectile_start = function() {
	var _startOffset = 32;
	projectile_start_x = x + lengthdir_x(_startOffset / 2, aim_direction);
	projectile_start_y = y + lengthdir_y(_startOffset / 2, aim_direction);
	reticle_x = x + lengthdir_x(_startOffset, aim_direction);
	reticle_y = y + lengthdir_y(_startOffset, aim_direction);
};
update_projectile_start();

// firing state
charge = 0; // ranges from zero to 1 and determines launch power
charge_speed = 0.05;
is_charging = false;
cooling_down = false;

shake_x = 0;
shake_y = 0;

dead = false;

// play aim sound?
play_aim_sound = true;
click_cooldown = 15;
