if ( can_fall ) instance_destroy();

xscale		= 0;
subsegment	= undefined;
image_angle = direction;
freeze		= false;

offset_x = x - giz_beast_bullet_obj_boss.x;
offset_y = y - giz_beast_bullet_obj_boss.y;

wait		= 0;
is_bone		= false;
is_muscle	= false;
is_face		= false;
phase		= giz_beast_bullet_get_phase();
life		= 1;
active		= false;

var _index = phase;
if ( phase == 2 ) {
	if ( giz_beast_bullet_obj_boss.life < giz_beast_bullet_obj_boss.life_max*.5 ) _index = giz.math.irand(2);
}
switch(_index){
	
	case 0: 
	is_face = true;
	life = 1;
	image_blend = c_white;
	image_xscale = 1 - ( 1/(grow+1) );
	sprite_index = giz_beast_bullet_spr_tentacle_face; break;	
	
	case 1: 
	life = 3;
	is_muscle = true;
	image_blend = giz_beast_bullet_obj_boss.colors[1];
	sprite_index = giz_beast_bullet_spr_tentacle_muscle; break;	
	
	case 2: 
	is_bone = true;
	life = 3;
	sprite_index = giz_beast_bullet_spr_tentacle_bone; break;	
	
}
if ( DIFFICULTY > 2 ) {
	life += ( DIFFICULTY * .2 );
}
fall = -8;
image_speed = 0;
image_index = giz.math.irand(image_number-1);