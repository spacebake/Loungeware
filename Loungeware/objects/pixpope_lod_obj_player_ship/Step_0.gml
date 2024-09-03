/// @description Insert description here
// You can write your code in this editor
spawn.update();
if(spawn.done) shrink.update();

if(!victory) {
	x = lerp(start, xstart, spawn.getPosition())
} else {
	escape.update();
	escapeShrink.update();
	x = lerp(xstart, room_width + 32, escape.getPosition())
}







