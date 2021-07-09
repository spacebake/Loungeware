randomize();
_start_y = y;
active_button = 0;
messages = ds_list_create();
members = ds_list_create();
key_press_timer = 0;
key_press_interval = 10;
score_list = ds_list_create();
score_max = 4;
score_changed = new n8fl_FDelegate(function(){});
image_speed = 0;
suspect = noone;
allow_count = 0;
ban_count = 0;

game_finished = new n8fl_FDelegate(function(){});

vy = 0;
grav = 0.4;
hop_force = 2;

_hit_tween = new n8fl_FTween(0, 1, 0.5);
	
_init = function(){
	game_finished.add(_on_game_finished);
	with(n8fl_admin_simulator_btn){
		clicked.add(other._on_btn_clicked);	
	}
}

_cleanup = function(){
	ds_list_destroy(messages);
	ds_list_destroy(score_list);
	ds_list_destroy(members);
}

_tick = function(){
	_hit_tween.update();
	if(_hit_tween.is_playing()){
		image_index = lerp(1.8, 0, _hit_tween.get_normalized_value());
	}else{
		image_index = 0;	
	}
	
	var input = 0;
	if(KEY_LEFT){
		input = -1;
	}else if(KEY_RIGHT){
		input = 1;	
	}
	
	if(input == 0){
		key_press_timer = 0;	
	}else{
		if(key_press_timer % key_press_interval == 0){
			_on_dir_keypress(input);
		}
		key_press_timer++;	
	}
	
	if(KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED){
		_on_select_keypress();	
	}
	
	y += vy;
	vy += grav;
	y= min(_start_y, y);
}

_on_dir_keypress = function(input){
	active_button += input;
	if(active_button < 0){
		active_button = 1;	
	}
	if(active_button > 1){
		active_button = 0;	
	}
}

_on_select_keypress = function(input){
	with(n8fl_admin_simulator_btn){
		if(index == other.active_button){
			click();	
		}
	}
}

_on_btn_clicked = function(btn){
	if(n8fl_admin_simulator_message.get_message_type() == btn.index){
		add_score_item(true);	
		var _snd_id = sfx_play(n8fl_admin_simulator_success_snd, 0.6, 0);
		//audio_sound_pitch(_snd_id, random_range(0.8,1.2));
	}else{
		add_score_item(false);
		var _snd_id = sfx_play(n8fl_admin_simulator_wrong_snd, 0.6, 0);
		//audio_sound_pitch(_snd_id, random_range(0.8,1);
	}
	
	if(instance_exists(suspect)){
		if(btn.index == n8fl_admin_simulator_EMessageType.Ban){
			suspect.banish(ban_count++);
			_hit_tween.reset();
			_hit_tween.play(1);
			vy = -hop_force;
			
			var _snd_id = sfx_play(n8fl_admin_simulator_hammer2_snd, 0.3, 0);
			audio_sound_pitch(_snd_id, random_range(0.8,1.2));
		
		}else{
			suspect.allow(allow_count++);	
		}
	}
}

_on_game_finished = function(){
	with(n8fl_admin_simulator_btn){
		visible = false;	
	}
	
	var t = get_score_correct_count() / score_max;
	if(t >= 0.6){
		var _snd_id = sfx_play(n8fl_admin_simulator_cheer_snd, 0.6, 0);
	}else{
		var _snd_id = sfx_play(n8fl_admin_simulator_laugh_snd, 0.6, 0);
	}
}

get_next_message = function(){
	if(ds_list_size(score_list) >= score_max){
		return undefined;
	}
	
	if(ds_list_size(messages) == 0){
		_create_messages();
	}
	
	var msg = messages[| 0];
	ds_list_delete(messages, 0);
	return msg;
}

get_next_member = function(){
	if(ds_list_size(score_list) >= score_max){
		return undefined;
	}
	
	if(ds_list_size(members) == 0){
		_create_members();	
	}
	
	var member = members[| 0];
	ds_list_delete(members, 0);
	
	suspect = instance_create_depth(x - 30, _start_y, depth+1, n8fl_admin_simulator_suspect);
	suspect.image_index = member.get_image_index();
	return member;		
}

get_active_button = function(){
	return active_button;	
}

add_score_item = function(item){
	ds_list_add(score_list, item);	
	score_changed.invoke(undefined);
	
	if(ds_list_size(score_list) >= score_max){
		game_finished.invoke();	
	}
}

_create_messages = function(){
	ds_list_clear(messages);	
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"Hot single Lounges in your area just go to \nhttps://12e5d.eu"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"How does Shaun Spahalding collision code work?"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"What's the square root of your mama"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"What's the max texture page size"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"Why does my game keep freezing"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"Ah lawd we loungin"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"Godot > GMS2"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"GMS2 > Godot"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"hey @admins I need help with Sahauns Spalding's colliding code"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"@ShaunJS @PixelatedPope @YellowAfterlife"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"Hi is this channel taken"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"I just joined what's going on?"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Okay,
			"Where can i ask about shaders?"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"@everyone"
		)
	);
	repeat(3){
		ds_list_shuffle(messages);
	}
}

_create_members = function() {
	ds_list_clear(members);	
	
	var role_pleb = c_white;
	var role_staff = c_magenta;
	var role_admin = c_aqua;
	
	//ds_list_add(members, new n8fl_admin_simulator_FMember("netfloz", c_blue, 0));
	ds_list_add(members, new n8fl_admin_simulator_FMember("pine", role_staff, 1));
	ds_list_add(members, new n8fl_admin_simulator_FMember("bulbs", role_pleb, 2));
	ds_list_add(members, new n8fl_admin_simulator_FMember("sahaun",role_staff,  3));
	ds_list_add(members, new n8fl_admin_simulator_FMember("mimpy", role_admin,  4));
	ds_list_add(members, new n8fl_admin_simulator_FMember("baku", role_staff,  5));
	ds_list_add(members, new n8fl_admin_simulator_FMember("amet", role_pleb,  6));
	ds_list_add(members, new n8fl_admin_simulator_FMember("mak", role_staff,  7));
	ds_list_add(members, new n8fl_admin_simulator_FMember("space",role_staff,  8));
	ds_list_add(members, new n8fl_admin_simulator_FMember("kat", role_staff,  9));
	ds_list_add(members, new n8fl_admin_simulator_FMember("josh", role_staff,  10));
	
	repeat(3){
		ds_list_shuffle(members);
	}
}

get_score_correct_count = function(){
	var result = 0;
	for(var i=0; i < ds_list_size(score_list); i++){
		result += score_list[| i] ? 1 : 0;	
	}
	return result;
}

_init();