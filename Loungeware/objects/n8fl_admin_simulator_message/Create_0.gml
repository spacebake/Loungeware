get_pos = function(){
	return new n8fl_FVector(x, y);	
}

ui_transform = new n8fl_FTransform(58,12);
ui_transform.set_parent(id);

member_label = new n8fl_FLabel();
member_label.set_parent(ui_transform);
member_label.set_local_pos_f(0, 0);
member_label.set_colour(c_red);
member_label.set_scale(0.5, 0.5);

ts_label = new n8fl_FLabel();
ts_label.set_parent(member_label);
ts_label.set_local_pos_f(0, 0);
ts_label.set_text("Just Now");
ts_label.set_colour(c_gbpink);
ts_label.set_padding_f(2, 1, 0, 0);
ts_label.set_scale(0.3, 0.3);

msg_label = new n8fl_FLabel();
msg_label.set_parent(ui_transform);
msg_label.set_local_pos_f(0, 12);
msg_label.set_colour(c_white);
msg_label.set_scale(0.8, 0.8);
msg_label.set_max_width(sprite_width - 8, 15);

game_over_label = new n8fl_FLabel();
game_over_label.set_local_pos_f(sprite_width/2, sprite_height/2);
game_over_label.set_parent(ui_transform);
game_over_label.set_halign(fa_center);
game_over_label.set_valign(fa_middle);

member_icon_padding = new n8fl_FPadding(5, 6, 0, 0);
msg = undefined;
member = undefined;
image_speed = 0;

start_x = x;
x = -1000;

_show_game_over_message = false;

in_tween = new n8fl_FTween(0, 0, 0.3);
in_tween.set_type(n8fl_ETween.EaseOutElastic);
out_tween = new n8fl_FTween(0, 0, 0.1);

_init = function(){
	in_tween.set_dest(start_x);
	in_tween.set_start(room_width + 50);
	
	out_tween.set_dest(-sprite_width - 50);
	out_tween.set_start(start_x);
	
	msg = n8fl_admin_simulator_player.get_next_message();
	member = n8fl_admin_simulator_player.get_next_member();
	
	out_tween.completed.add(_on_ease_out_completed);
	_ease_in();
}

_tick = function(){
	in_tween.update();
	out_tween.update();
	
	if(in_tween.is_playing()){
		x = in_tween.value();
	}else if(out_tween.is_playing()){
		x = out_tween.value();	
	}
}

_draw = function(){	
	draw_self();
	
	//if(_show_game_over_message){
	//	image_index = 1;
	//	game_over_label.set_text("Nice job!");
	//	game_over_label.draw();
		
	//} else {
	if(member != undefined){
		draw_sprite(
			n8fl_admin_simulator_pfp_spr, 
			member.get_image_index(),
			x + member_icon_padding.get_left(), 
			y + member_icon_padding.get_top()
		);

		member_label.set_colour(member.get_colour());
		member_label.set_text(member.get_name());
		member_label.draw();
		
		ts_label.set_local_pos_f(
			member_label.get_string_width(), 
			ts_label.get_local_pos().get_y()
		);
		ts_label.draw();
	}
	
	if(msg != undefined){
		msg_label.set_text(msg.get_text());
		msg_label.draw();
	}
	//}
}

_ease_in = function(){
	if(in_tween.is_playing() == false && out_tween.is_playing() == false){
		in_tween.reset();
		in_tween.play();
		return true;
	}
	return false;
}

_ease_out = function(){
	if(in_tween.is_playing() == false && out_tween.is_playing() == false){
		out_tween.reset();
		out_tween.play();
		return true;
	}
	return false;
}

_on_ease_out_completed = function(){
	var admin_player = n8fl_admin_simulator_player;
	msg = admin_player.get_next_message();
	member = admin_player.get_next_member();
	
	if(
		ds_list_size(admin_player.score_list) == admin_player.score_max &&
		_show_game_over_message == false
	){
		_show_game_over_message = true;		
		
		var correct_score = admin_player.get_score_correct_count();
		var t = correct_score / admin_player.score_max;
		
		var str = "";
		
		if(t >= 1.0){
			str = "Excellent Adminship!"	
		}else if(t >= 0.6){
			str = "Not bad!"	
		}else{
			if(admin_player.ban_count > admin_player.allow_count){
				str = "An unjust tyrant"
			}else{
				str = "A pushover"
			}	
		}
		
		msg = new n8fl_admin_simulator_FMessage(
			0, 
			"Score: " + string(correct_score) + "/" + string(admin_player.score_max) + "" + "\n" +
			"Rating: " + str
		);
		
		if(t >= 0.6){
			microgame_win();	
		}else{
			microgame_fail();	
		}
		
		member = new n8fl_admin_simulator_FMember("net8floz", c_aqua,  0);
		
		_ease_in();
	}else if(msg != undefined){
		_ease_in();	
	}
}

next = function(){
	if(ds_list_size(n8fl_admin_simulator_player.score_list) >= n8fl_admin_simulator_player.score_max){
		return false;	
	}
	
	return _ease_out();
}

get_message_type = function(){
	if(msg == undefined){
		return - 1;	
	}
	return msg.get_type();	
}

n8fl_execute_next_once(_init);