global.n8fl_tick = 0;
global.n8fl_ticked = new n8fl_FDelegate(function(){
	global.n8fl_tick++;
});