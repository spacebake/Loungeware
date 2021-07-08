var admin_player = n8fl_admin_simulator_player;
badges = ds_list_create();
badge_count = admin_player.score_max;

//for(var i=0; i < badge_count; i++) {
//	var xx = 
//		room_width - (badge_count-1) * sprite_get_width(n8fl_admin_simulator_badge_spr) -
//		((badge_count / 2) - 0.5) * sprite_get_width(n8fl_admin_simulator_badge_spr) +
//		i * sprite_get_width(n8fl_admin_simulator_badge_spr);
//	var yy = room_height - 3;
//	var badge = instance_create_depth(xx, yy, depth, n8fl_admin_simulator_badge);
//	ds_list_add(badges, badge);
//}

_on_score_changed = function(){
	//var admin_player = n8fl_admin_simulator_player;
	//for(var i=0; i < badge_count; i++){
	//	if(ds_list_size(admin_player.score_list) > i){
	//		var is_good = admin_player.score_list[| i];
	//		var badge = badges[| i];
	//		badge.image_blend = is_good ? c_white : make_color_rgb(100,100,100);
	//		badge.image_index = is_good ? 1 : 2;
			
	//	}
	//}
}

_cleanup = function(){
	ds_list_destroy(badges);
}

admin_player.score_changed.add(_on_score_changed);