/// @description Update position

// Update target if none is set
if (target == noone)
{
	// search platforms and see if one is to the right of the brush
	var _minTargetX = 0;
	with (platform)
	{
		if (x > other.x) // is it to the left of the brush?
		{
			if (other.target == noone) // is this the first one being checked?
			{
				_minTargetX = x;
				other.target = id;
			}
			else if (x < _minTargetX) // is it further left than the other brushes to the right?
			{
				_minTargetX = x;
				other.target = id;
			}
		}
	}
}
else
{
	// put brush down when it starts passing brush
	if (target.bbox_left <= x + brush_buffer)
	{
		sprite_index = noah_makimono_spr_brush_down;	
	}
	

	y = lerp(y, target.y, lerp_speed);

	if (target.bbox_right <= x)
	{
		target = noone;	
		sprite_index = noah_makimono_spr_brush_up;
	}
}
if (game_fail)
{
	sprite_index = noah_makimono_spr_brush_up;
	x_speed += x_acceleration;
	x += x_speed;	
}



