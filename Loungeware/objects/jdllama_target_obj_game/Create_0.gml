difficulties = [
	{total: 4, targetSpeed: 1, canBackwards: false, shots: 6},
	{total: 5, targetSpeed: 1, canBackwards: false, shots: 6},
	{total: 6, targetSpeed: 1, canBackwards: false, shots: 5},
	{total: 7, targetSpeed: 1.1, canBackwards: true, shots: 5},
	{total: 8, targetSpeed: 1.25, canBackwards: true, shots: 4},
];

_difficulty = difficulties[DIFFICULTY - 1];

totalShots = _difficulty.shots;
totalTargets = _difficulty.total;

shotsLeft = totalShots;

active = true;

scope_manager = instance_create_layer(x, y, "Manager", jdllama_target_obj_scope_mgr);
shot_manager = instance_create_layer(238, 158, "Manager", jdllama_target_obj_shots_mgr);
with instance_create_layer(x, y, "Manager", jdllama_target_obj_target_mgr) {
	difficulty = other._difficulty;
}

_step = function() {
	if(shot_manager) shot_manager.shots = shotsLeft;
	if(active == true) {
		if(TIME_REMAINING < 60) {
			if((totalShots == shotsLeft) && (totalTargets == instance_number(jdllama_target_obj_target))) {
				instance_create_layer(120, 80, "Message", jdllama_target_obj_msg_pacifist);
				microgame_win();
				microgame_music_stop(1);
				sfx_play(jdllama_target_snd_pacifist,1.2,false);
				active = false;
			}
		}
		if(KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
			if(shotsLeft > 0) {
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
						other.shotsLeft--;
						if(other.shotsLeft <= 0) {
							microgame_fail();
							instance_create_layer(120, 80, "Message", jdllama_target_obj_msg_noshots);
							active = false;
						}
					}
				}
				if(instance_number(jdllama_target_obj_target) <= 0) {
					microgame_win();
					instance_create_layer(120, 80, "Message", jdllama_target_obj_msg_win);
					microgame_music_stop(1);
					sfx_play(jdllama_target_snd_victory,1.2,false);
					active = false;
				}
			}
			
		}
	}
	
}