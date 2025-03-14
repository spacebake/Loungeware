
// handle destruction
if (instance_place(x, y, noah_artillery_obj_explosion) and !dead)
{
	image_index = 0;
	sprite_index = noah_artillery_spr_player_die;
	dead = true;
	sfx_play(noah_artillery_sfx_mech_destroy);
}


var _inputLeft = 0;
var _inputRight = 0;
var _inputCharge = false;
var _inputFire = 0;
// Take input
if (!dead)
{
	_inputLeft = (KEY_LEFT or KEY_UP);
	_inputRight = (KEY_RIGHT or KEY_DOWN);
	_inputCharge = (KEY_PRIMARY or KEY_SECONDARY);
	_inputFire = (KEY_PRIMARY_RELEASED or KEY_SECONDARY_RELEASED);
}


if (!is_charging and _inputCharge and !cooling_down)
{
	is_charging = true;
	sfx_play(noah_artillery_sfx_charge, 1, false);
}

// Check for firing
if (is_charging)
{
	charge += charge_speed;
	charge = clamp(charge, 0, 1);
	if (_inputFire)
	{
		instance_create_depth(projectile_start_x, projectile_start_y, depth - 1, noah_artillery_obj_missile);
		cooling_down = true;
		is_charging = false;
		sfx_play(noah_artillery_sfx_fire);
	}
}

if (cooling_down)
{
	charge = lerp(charge, 0, 0.1); // cool down to zero
	if (charge <= 0.01)
	{
		charge = 0;
		cooling_down = false;
	}
}

// shake if fully charged
if (charge == 1 and random(100) > 50)
{
	shake_x = random(2);
	shake_y = random(2);
}

var _moveDirection = _inputLeft - _inputRight;

aim_direction += _moveDirection;
aim_direction = clamp(aim_direction, 0, 90);

// handle aim clicking sound
if (_moveDirection != 0 and play_aim_sound)
{
	play_aim_sound = false;
	sfx_play(noah_artillery_sfx_aim);
	alarm_set(0, click_cooldown);
}
else if (_moveDirection == 0 and !play_aim_sound)
{
	play_aim_sound = true;
}

// Update sprite
if (!dead)
{
	image_index = (image_number - 1) * (aim_direction) / (90);
}


// Update reticle position
update_projectile_start();
