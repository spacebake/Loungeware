if (selected && instance_exists(tfg_guess_obj_answer) && abs(tfg_guess_obj_answer.y - tfg_guess_obj_answer.target_y) < 2) {
	if (!made_a_larl) {
		var spr = won ? tfg_spr_larl_thumbup : tfg_spr_larl_thumbdown;
	
		with (instance_create_layer(0, 0, "Larl", tfg_guess_obj_larl_thumbup))
			sprite_index = spr;
			
		made_a_larl = true;
	}
}