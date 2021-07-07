padding = new n8fl_FVector(4,12);
line_height = 20;
msg = undefined;
text_scale = 0.7;
start_x = x;
x = -1000;
in_tween = new n8fl_FTween(0, 0, 0.3);
in_tween.type = n8fl_ETween.EaseOutElastic;
out_tween = new n8fl_FTween(0, 0, 0.1);

out_tween.completed.add(function(){
	msg = n8fl_admin_simulator_player.get_next_message();
	if(msg != undefined){
		_ease_in();	
	}
});

_init = function(){
	in_tween.dest = start_x;
	in_tween.start = room_width + 50;
	in_tween.play_speed = 0;
	
	out_tween.play_speed = 0;
	out_tween.dest = -sprite_width - 50;
	out_tween.start = start_x;
	
	msg = n8fl_admin_simulator_player.get_next_message();
	_ease_in();
}

_draw = function(){
	in_tween.update();
	out_tween.update();
	
	if(in_tween.is_playing()){
		x = in_tween.value();
	}else if(out_tween.is_playing()){
		x = out_tween.value();	
	}
	
	if(msg != undefined){
		draw_self();
		draw_set_font(fnt_frogtype);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_ext_transformed(x + padding.x, y + padding.y, msg.text, line_height, (sprite_width - padding.x * 2) / text_scale, text_scale, text_scale, 0);
	}
}

_ease_in = function(){
	if(ds_list_size(n8fl_admin_simulator_player.score_list) >= n8fl_admin_simulator_player.score_max){
		return false;	
	}
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

next = function(){
	return _ease_out();
}

get_message_type = function(){
	if(msg == undefined){
		return - 1;	
	}
	return msg.type;	
}

_init();