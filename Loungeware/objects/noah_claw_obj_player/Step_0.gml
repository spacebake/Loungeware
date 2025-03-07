
if (crane_active)
{
	var _vertInput = KEY_DOWN - KEY_UP;
	y += _vertInput * crane_speed;
	y = clamp(y, 0, goal_y);
}

// fail condition
var _bulletInst = instance_place(x, y, noah_claw_obj_bullet_parent)
if (_bulletInst and !success and !falling)
{
	var _hitX = _bulletInst.x;
	var _hitY = _bulletInst.y;
	instance_create_depth(_hitX, _hitY, depth - 1, noah_claw_obj_hit_fx);
	crane_active = false;
	falling = true;
	cable_stay_y = y;
}

if (falling)
{
	image_angle += 5;;
	y += crane_speed;
	microgame_fail();
}

if (y == goal_y and !falling and !success)
{
	crane_active = false;
	success = true;
	with(noah_claw_obj_bullet_parent)
	{
		shrinking = true;	
	}
	with (noah_claw_obj_emitter_parent)
	{
		active = false;
	}
	microgame_win();
}

if (success)
{
	y = lerp(y, success_y, lerp_speed);
	if (abs(y - success_y) < 0.1)
	{
		x -= crane_speed;	
	}
}