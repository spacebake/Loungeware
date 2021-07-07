enum n8fl_reach_for_it_mister_EScenery{
	Sky,
	Sand,
	Plateau,
	Clouds,
	CactusForeground,
	CactusBackground
}
cloud_x = -100;


draw_para = function(_image_index, _scale, _offset_x){
	var reach_player = n8fl_reach_for_it_mister_player;
	if(instance_exists(reach_player) == false){
		return;	
	}
	
	var xx = (reach_player.par_scroll - reach_player.par_scroll_max) * _scale;
	draw_sprite(
		n8fl_reach_for_it_mister_bg_spr, 
		_image_index, 
		xx + _offset_x,
		0
	);
}
