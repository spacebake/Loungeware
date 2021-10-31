// Create targets
if (targets_to_make > 0) {

	// Create targets if there are less than can be shown
	if (instance_number(objfrog_ys_o_target) < targets_shown) {
	
		// Get some random coords
		var target_width = sprite_get_width(objfrog_ys_s_targets);
		var target_height = sprite_get_height(objfrog_ys_s_targets);
		xx = irandom_range(target_width, room_width - target_width);
		yy = irandom_range(target_height, room_height - target_height);

		
		while (
			point_distance(xx, yy, objfrog_ys_o_cowboy.x, objfrog_ys_o_cowboy.y) < 64 || 
			place_meeting(xx, yy, objfrog_ys_o_collision_parent)
		) {
			xx = irandom_range(target_width, room_width - target_width);
			yy = irandom_range(target_height, room_height - target_height);
		}

	
		// Create the target
		instance_create_depth(xx, yy, -yy, objfrog_ys_o_target);
		targets_to_make--;
	}

}
