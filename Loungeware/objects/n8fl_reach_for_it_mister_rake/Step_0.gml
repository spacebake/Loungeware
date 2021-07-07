event_inherited();

if(TIME_REMAINING == 0 || is_dead){
	exit;	
}

var reach_player = n8fl_reach_for_it_mister_player;
if(instance_exists(reach_player) == false){
	exit;	
}

var diff = DIFFICULTY;
var m = diff < 3 ? 35 : 28;
if(has_gun && TIME_REMAINING % m == 0){
	if(combo_index < reach_player.combo_max){
		var emote = reach_player.combo[combo_index];
		spawn_emote(emote);
		combo_index++;	
		shoot(combo_index < reach_player.combo_max);
	}
}