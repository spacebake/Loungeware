giz_init;

giz.game.end_delay = 60;
giz.game.on_finish.add(function(){
	with ( giz_beast_bullet_obj_bullet ) instance_destroy();
});

effect = layer_get_fx("ImpactBlur");

//switch(DIFFICULTY){
//	case 1 : giz.game.time_set(7); break;
//	case 2 : giz.game.time_set(6); break;
//	case 3 : giz.game.time_set(5); break;
//	case 4 : giz.game.time_set(5); break;
//	case 5 : giz.game.time_set(5); break;
//}