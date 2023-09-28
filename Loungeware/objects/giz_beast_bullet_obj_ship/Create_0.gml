hsp			= 0;
vsp			= 0;
wait		= 30;
bullet		= 1;
spread		= 8;
lose		= false;
timer		= 6 - clamp(DIFFICULTY, 2, 4);
timer_max	= timer;

create_bullet = function(){
	if ( timer && !--timer ) {
		timer = timer_max;
		var xx = ( bullet-1 ) * spread * .5;
		for ( var i=0; i<bullet; i++ ){
			var _x = ( x - xx ) + i * spread;
			var _y = bbox_top;
			
			var dir = point_direction(_x, _y, x, y + 32);
			var ang = sign(_x - x);
			instance_create_layer(x, bbox_top, layer, giz_beast_bullet_obj_bullet, {
				speed		: -10,
				image_angle : dir+180,
				direction	: dir,
				ang			: ang
			});
		}
	}
}