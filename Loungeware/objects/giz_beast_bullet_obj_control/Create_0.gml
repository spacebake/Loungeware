giz_init;

giz.game.end_delay = 60;
giz.game.on_finish.add(function(){
	with ( giz_beast_bullet_obj_bullet ) instance_destroy();
});

effect = layer_get_fx("ImpactBlur");