/*
if (yosi_EFT_obj_firetruck.state == "drive")
	{
	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_text(100, 45, "Mash to go faster!");
	draw_set_halign(fa_left);
	}
*/
var _mash = sign
	(
	KEY_PRIMARY_PRESSED +
	KEY_SECONDARY_PRESSED +
	KEY_RIGHT_PRESSED +
	KEY_UP_PRESSED +
	KEY_LEFT_PRESSED +
	KEY_DOWN_PRESSED
	);
if (_mash)
	{
	yosi_EFT_draw_action_lines(VIEW_X + (VIEW_W div 2), VIEW_Y + (VIEW_H div 2), VIEW_W, VIEW_H, irandom_range(10, 20), 15, 40, 20, c_white, random(100))
	}