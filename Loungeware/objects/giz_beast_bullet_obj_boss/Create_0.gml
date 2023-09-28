image_speed = 0;
image_blend = make_color_hsv(random(255), 100, 200);

life_max	= 0;
switch(DIFFICULTY){
	case 1 : life_max = 20; break;
	case 2 : life_max = 25; break;
	case 3 : life_max = 35; break;
	case 4 : life_max = 60; break;
	case 5 : life_max = 70; break;
}
life		= life_max;

width		= sprite_get_width(giz_beast_bullet_spr_larold_face);
height		= sprite_get_height(giz_beast_bullet_spr_larold_face);
phase		= 0;
phase_max	= 3;
hit			= 0;
angle		= 0;
angle_move	= 0;
colors		= [ #FFC89C, #C25D7A, #FFF0E5 ];
surface		= array_create(3, -1);

alarm[0] = 30;
remove_surfaces = function(){
	array_foreach(surface, function(surf){
		if ( surface_exists(surf) ) surface_free(surf);
	});
}	
verify_surfaces = function(){
	for ( var i=0; i<array_length(surface); i++ ){
		if ( !surface_exists(surface[i]) ) {
			surface[i] = surface_create(width, height);
			surface_set_target(surface[i]);
			draw_clear_alpha(0, 0);
			draw_sprite(giz_beast_bullet_spr_larold_face, i, width * .5, height * .5);
			surface_reset_target();
		}
	}	
}
subtract_surfaces = function(){
	
	if ( giz.game.finished ) return;
	
	if ( hit < -2 ) hit = 2;
	surface_set_target(surface[phase]);
	gpu_set_blendmode(bm_subtract);
	
	var xx = giz.math.rand(0, width);
	var yy = (( life/life_max )*height);
	draw_sprite(giz_beast_bullet_spr_explosion_debris, irandom(sprite_get_number(giz_beast_bullet_spr_explosion_part)), xx, yy);
	repeat(giz.math.irand(2, 5)){
		var _rx = xx + giz.math.rand(-8, 8);
		var _ry = yy + giz.math.rand(-8, 8);
		draw_sprite(giz_beast_bullet_spr_explosion_debris, irandom(sprite_get_number(giz_beast_bullet_spr_explosion_part)), _rx, _ry);	
	}
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
}
next_phase = function(){
	
	// Clear damagers
	with ( giz_beast_bullet_obj_bullet ) instance_destroy();
	with ( giz_beast_bullet_obj_tentacle ) instance_destroy();
	
	// Phase check
	phase++;
	if ( phase == phase_max ){
		giz.game.set_win(true); 
		giz.game.finish();
		
		microgame_music_stop(0);
		sfx_play(giz_beast_bullet_snd_win, 1, 0);
		return;
	}
	
	sfx_play(giz_beast_bullet_snd_explosion_big, 1, 0);
	
	// Reset things
	alarm[0] = 15;
	life_max += phase * 20;
	life = life_max;
	
	// Create massive explosion
	repeat(20) {
		var len = giz.math.rand(8, 32);
		var dir = giz.math.rand(360);
		giz_beast_bullet_explode(colors[phase], 10, x + lengthdir_x(len, dir), y + lengthdir_y(len, dir));
	}
	
	// Clear surfaces	
	if ( surface_exists(surface[phase-1]) ) {
		surface_set_target(surface[phase-1]);
		draw_clear_alpha(0, 0);
		surface_reset_target();
	}
}


