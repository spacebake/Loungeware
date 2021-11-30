#region Create targets

	if (targets_to_make > 0) {

		// Create targets if there are less than can be shown
		if (instance_number(objfrog_ys_o_target) < targets_shown) {
	
			with (instance_create_depth(-64, -64, 0, objfrog_ys_o_target)) {
		
				var xx = irandom_range(sprite_width, room_width - sprite_width);
				var yy = irandom_range(sprite_height, room_height - sprite_height);
			
				while (
					point_distance(xx, yy, objfrog_ys_o_cowboy.x, objfrog_ys_o_cowboy.y) < 64 ||  
					point_distance(xx, yy, objfrog_ys_o_collision_parent.x, objfrog_ys_o_collision_parent.y) < 64 ||
					place_meeting(xx, yy, objfrog_ys_o_target) ||
					place_meeting(xx, yy, objfrog_ys_o_collision_parent)
				) {
					xx = irandom_range(sprite_width, room_width - sprite_width);
					yy = irandom_range(sprite_height, room_height - sprite_height);
				}
			
				x = xx;
				y = yy;
				depth = -y;
			
				if (x < objfrog_ys_o_cowboy.x) {
					image_xscale = -1;
				}
		
			}
		

			targets_to_make--;
		}

	}

#endregion
#region Game win

	if (targets_hit >= TOTAL_TARGETS && !MICROGAME_WON) {
		// Won the game!
		sfx_play(objfrog_ys_sfx_yeehawww, 1, false);
		microgame_win();
	}

#endregion