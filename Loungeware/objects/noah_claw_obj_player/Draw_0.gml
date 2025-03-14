/// @description Insert description here
// You can write your code in this editor

var _cableY = y;
if (falling)
{
	_cableY = cable_stay_y;	
}
draw_sprite(noah_claw_spr_cable, 0, x, _cableY);

draw_self();

if (success)
{
	draw_sprite(larold_sprite, 0, x, y + larold_y_offset);	
}
