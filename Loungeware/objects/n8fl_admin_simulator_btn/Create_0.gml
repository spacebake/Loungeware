click_scale_tween = new n8fl_FTween(0, 1, 0.05);
click_scale_tween.play(-1);
clicked = new n8fl_FDelegate(function(){});

click = function(){
	if(n8fl_admin_simulator_message.next()){
		clicked.invoke(id);
		click_scale_tween.play(1);
		click_scale_tween.completed.once(function(){
			click_scale_tween.play(-1);
		});
	}
}

_draw = function(){
	var scale = lerp(1,0.8,click_scale_tween.value());
	image_xscale = scale;
	image_yscale = scale;

	image_index =n8fl_admin_simulator_player.get_active_button() == index ? 1 : 0;
	draw_self();
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, y, text, image_xscale, image_yscale, image_angle);
}