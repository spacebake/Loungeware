/// @description Insert description here
// You can write your code in this editor

var _horInput = KEY_RIGHT - KEY_LEFT;
var _jumpInput = (KEY_PRIMARY_PRESSED or KEY_SECONDARY_PRESSED or KEY_UP_PRESSED);
var _jumpReleased = (KEY_PRIMARY_RELEASED or KEY_SECONDARY_RELEASED or KEY_UP_RELEASED);




// vertical motion
if ((y_speed == 0 or !double_jumped)  and _jumpInput)
{
	if (!on_ground)
	{
		sfx_play(noah_makimono_sfx_double_jump);
		double_jumped = true;
		instance_create_depth(x, bbox_bottom, depth + 1, noah_makimono_obj_jump_fx);
	}
	else
	{
		sfx_play(noah_makimono_sfx_jump);	
	}
	y_speed = -jump_force;
	on_ground = false;
	sprite_index = noah_makimono_spr_frog_jump;
	image_index = double_jumped;
}
y_speed += grav;
// Add hold force
if (!on_ground and _jumpReleased and y_speed < -5)
{
	y_speed = -5;
}

y_speed = min(y_speed, terminal_velocity);


// horizontal motion
if (_horInput != 0)
{
	// update horizontal direction
	image_xscale = _horInput;
	if (on_ground)
	{
		x_speed = _horInput * run_speed;
		if (sprite_index != noah_makimono_spr_frog_land)
		{
			sprite_index = noah_makimono_spr_frog_walk;	
		}
	}
	else
	{
		x_speed += scroll_speed;
		x_speed += _horInput * air_acceleration;
		x_speed = clamp(x_speed, -max_air_speed, max_air_speed);
	}
}
else
{
	x_speed = 0;	
	if (sprite_index != noah_makimono_spr_frog_land and on_ground)
	{
		sprite_index = noah_makimono_spr_frog_idle;	
	}
}
x_speed -= scroll_speed;
x += x_speed;

// look ahead for y position
// Only collide vertically when moving down
var _movingDown = y_speed > 0;
if (_movingDown)
{
	var _nextY = y + y_speed;
	var _collisionInstY = instance_place(x, _nextY, platform);
	if (_collisionInstY)
	{
		if (bbox_bottom <= _collisionInstY.bbox_top)
		{
			if (!on_ground)
			{
				sprite_index = noah_makimono_spr_frog_land;
				alarm_set(0, 15);
			}
			y_speed = 0;
			on_ground = true;
			double_jumped = false;
			y = _collisionInstY.bbox_top - (1 + bbox_bottom - y);
		}
	}
	else
	{
		on_ground = false;	
	}
}
y += y_speed;


// If you exit the left, right or bottom of the screen, lose
if (bbox_right < 0 or bbox_left > room_width or bbox_top > room_height)
{
	microgame_fail();	
	instance_create_depth(x, y, depth - 1, noah_makimono_obj_spill);
	var _bgLayer = layer_get_id("Background");
	layer_hspeed(_bgLayer, 0);
	with (platform)
	{
		scroll_speed = 0;	
	}
	noah_makimono_obj_brush.game_fail = true;
	sfx_play(noah_makimono_sfx_lose);
	instance_destroy();
}

