/// @desc
if (global.final_timer < 0)
{	
	var angle = 0;
	var size = 0;
	var x_ = 0;
	var y_ = 0;
	for (var i = 0; i < length; i++)
	{
		var text = new_menu[i];
		draw_set_falign(fa_middle,fa_center);
		if (i == cursor)
		{
			x_ = lengthdir_x(len, ang);
			y_ = lengthdir_y(len, ang);
			text = string_insert("> ", text, 0);
			angle = wave(-2,2, 2, false);
			size = wave(1,1.3, 2, false);
		}
		else
		{
			angle = 0;	
			x_ = 0;
			y_ = 0;
			size = 1;
		}
		draw_text_transformed(final_x + x_,((initial_y - 30) + i * 50) + y_, text, size,size, angle);	
		draw_text(final_x,text_y + wave(3,-3, 1, false), question);
	}
}