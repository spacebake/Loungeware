/// @description Insert description here
// You can write your code in this editor
var _layer = layer_get_id("Stars");
repeat(100){
	var _id = layer_sprite_create(_layer, random(room_width), random(room_height), pixpope_lod_spr_diamond);
	var _scale = random_range(.05, .15);
	layer_sprite_xscale(_id, _scale);
	layer_sprite_yscale(_id, _scale);
	layer_sprite_blend(_id, choose(#f1f2db, #f1f2db, #f1f2db, #f1f2db, #f1f2db, #f1f2db, 
																 #6f817e, #6f817e, #6f817e, #6f817e, 
																 #f45f5a,
																 #8cbdfc,))
	layer_sprite_angle(_id, random(360));
}







