function giz_laronin_constr_player(_opponent=false) constructor {
	
	parent	= other;
	offset	= ( _opponent ? -1 : 1 );
	move	= 0;
	x		= parent.x + ( 64 * -offset );
	y		= parent.y;
	sprite	= {
		idle	: ( _opponent ? giz_laronin_spr_n8fl_idle : giz_laronin_spr_larold_idle ),
		slash	: ( _opponent ? giz_laronin_spr_n8fl_slash : giz_laronin_spr_larold_slash ),
		dead	: ( _opponent ? giz_laronin_spr_n8fl_dead : giz_laronin_spr_larold_dead ),
	}
	sprite.current = sprite.idle;
	
	static onEnd = function(won=false){
		x				= parent.x + ( 18 * offset );
		sprite.current	= ( won ? sprite.slash : sprite.dead );
		move			= ( won ? 0 : 16*-offset );
	}
	static onUpdate = function(){
		move = lerp(move, 0, 0.1);
		x	+= move;
	}
	static onDraw = function(){
		draw_sprite_ext(sprite.current, current_time/90, x, y, offset, 1, 0, c_white, 1);	
	}
	
}
function giz_laronin_constr_signal() constructor {
	
	active = false;
	parent = other;
	static trigger = function(){ 
		active = !active;
		if ( active ) sfx_play(giz_laronin_snd_signal, 1, 0);
	}
	static onDraw = function(){
		if ( !active ) return;
		draw_sprite_ext(giz_laronin_spr_signal, 0, parent.x+random_range(-2, 2), (parent.y+random_range(-2, 2))-16, 1, 1, 0, c_white, 1);
	}	
	
}