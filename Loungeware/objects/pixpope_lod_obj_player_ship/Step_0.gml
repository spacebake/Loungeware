/// @description Insert description here
// You can write your code in this editor
spawn.update();
if(spawn.done) shrink.update();

if(!___MG_MNGR.microgame_won) {
	x = lerp(start, xstart, spawn.getPosition())
} else {
	escape.update();
	escapeShrink.update();
	x = lerp(xstart, room_width + 32, escape.getPosition())
}







