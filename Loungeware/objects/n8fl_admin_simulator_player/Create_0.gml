enum n8fl_admin_simulator_EMessageType {
	Ban,
	Help,
	Technical
}

function n8fl_admin_simulator_FMessage(_type, _text) constructor {
	type = _type;
	text = _text;
}

active_button = 0;
messages = ds_list_create();
key_press_timer = 0;
key_press_interval = 10;
score_list = ds_list_create();
score_max = 3;
score_changed = new n8fl_FDelegate(function(){});
	
_init = function(){
	
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"Hot single Lounges in your area just go to https://suckmy.lounge/scam"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Help,
			"How does Shaun Spauldings collision code work?"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Technical,
			"I have a room that's way bigger than I can ever fit content in why is it so slow"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"@everyone"
		)
	);
	ds_list_add(
		messages, 
		new n8fl_admin_simulator_FMessage(
			n8fl_admin_simulator_EMessageType.Ban,
			"@everyone please join my discord server"
		)
	);
	ds_list_shuffle(messages);
	
	with(n8fl_admin_simulator_btn){
		clicked.add(other._on_btn_clicked);	
	}
}

_cleanup = function(){
	ds_list_destroy(messages);
	ds_list_destroy(score_list);
}

_tick = function(){
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
}

_on_dir_keypress = function(input){
	active_button += input;
	if(active_button < 0){
		active_button = 2;	
	}
	if(active_button > 2){
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
	}else{
		add_score_item(false);
	}
}

get_next_message = function(){
	if(ds_list_size(messages) == 0){
		return undefined;	
	}
	var msg = messages[| 0];
	ds_list_delete(messages, 0);
	return msg;
}

get_active_button = function(){
	return active_button;	
}

add_score_item = function(item){
	ds_list_add(score_list, item);	
	score_changed.invoke(undefined);
}

_init();