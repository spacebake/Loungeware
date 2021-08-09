_step = function() {
	if(KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
		var scope = jdllama_target_obj_scope_mgr.middleScope;
		if(jdllama_target_obj_scope_mgr.leftScope.scopeActive == true) {
			scope = jdllama_target_obj_scope_mgr.leftScope;
		}
		else if(jdllama_target_obj_scope_mgr.rightScope.scopeActive == true) {
			scope = jdllama_target_obj_scope_mgr.rightScope;
		}
		with scope {
			if(place_meeting(x, y, jdllama_target_obj_target)) {
				var inst = instance_place(x, y, jdllama_target_obj_target);
				instance_destroy(inst);
				sfx_play(jdllama_target_snd_shot_good,1.2,false);
			}
			else {
				sfx_play(jdllama_target_snd_shot_bad,1.2,false);
			}
		}
		if(instance_number(jdllama_target_obj_target) <= 0) {
			microgame_win();
		}
	}
}