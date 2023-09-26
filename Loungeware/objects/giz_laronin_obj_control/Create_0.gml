// Players
player		= new giz_laronin_constr_player();
opponent	= new giz_laronin_constr_player(true);

// Various
signal		= new giz_laronin_constr_signal()
alpha		= 0;
flash		= 1;

sfx_play(giz_laronin_snd_start, 1, 0)

// Timer
timer_buff	= 43 - ( DIFFICULTY * 5 );
timer		= 60 * irandom_range(1, 7);

// States 
state_start	= function(){
	timer--;
	if ( timer == timer_buff+1 ) signal.trigger();
	if ( KEY_ANY_PRESSED ) state = state_lose;
	
	if ( timer == timer_buff ) state = state_input;
}
state_input = function(){
	timer--;
	if ( timer > 0 && KEY_ANY_PRESSED ) state = state_win;
	if ( timer <= -1 ) state = state_lose;
}
state_win	= function(){
	
	microgame_win();
	state = state_wait;
	timer = 60;
	
	player.onEnd(true);
	opponent.onEnd(false); 
	gameEnd(true);
	signal.trigger();
	
}
state_lose = function(){
	
	microgame_fail();
	state = state_wait;
	timer = 60;
	
	player.onEnd(false);
	opponent.onEnd(true);
	gameEnd(false);
	signal.active = false;
	
}	
state_wait = function(){
	timer--;
	if ( timer <= 0 ) microgame_end_early();
}
gameEnd = function(_won=false){
	sfx_play((_won ? giz_laronin_snd_win : giz_laronin_snd_lose), 1, 0);
	flash = 1;
}

// State set
state = state_start;
	
// Update
onUpdate = function(){

	alpha += 0.0005;
	flash = lerp(flash, 0, 0.1);
	state();
	
	player.onUpdate();
	opponent.onUpdate();
	
}
	
// Draw
onDraw = function(){
	
	// Players
	player.onDraw();
	opponent.onDraw();
		
	// Sunset
	draw_set_alpha(alpha);
	draw_set_color(#1A1721);
	draw_rectangle(0, 0, room_width, room_height, false);
	
	// Signal
	signal.onDraw();
	
	// FX flash
	draw_set_alpha(flash);
	draw_set_color(c_white);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_alpha(1);
	
}
