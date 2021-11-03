randomize();
_travel_speed = -4	;
_chars = ds_list_create();

_init = function(){
	inst_n8fl_escape2_player.landed.add(_on_player_land);
}

_cleanup = function(){
	ds_list_destroy(_chars);
}

_on_player_land = function(was_success){
	if(was_success){
		microgame_win();
		_travel_speed *= 3;
	}else{
		microgame_fail();
	}
}

get_travel_speed = function() { return _travel_speed; }

get_next_char = function(){
	if(ds_list_size(_chars) == 0){
		_generate_chars();	
	}
	var char = _chars[| 0];
	ds_list_delete(_chars, 0);
	return char;
}

_generate_chars = function(){
	ds_list_clear(_chars);
	ds_list_add(_chars, n8fl_reach_for_it_mister_cjosh_spr);
	ds_list_add(_chars, n8fl_reach_for_it_mister_cmak_spr);
	ds_list_add(_chars, n8fl_reach_for_it_mister_cpine_spr);
	ds_list_add(_chars, n8fl_reach_for_it_mister_cmimps_spr);
	ds_list_add(_chars, n8fl_reach_for_it_mister_csahaun_spr);
	ds_list_shuffle(_chars);
}

n8fl_execute_next_once(_init);