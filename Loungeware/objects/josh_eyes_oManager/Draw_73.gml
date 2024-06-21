/// @desc
if (global.final_timer < 0)
{	
	
	draw_set_halign(fa_center);
	draw_text(final_x,text_y + josh_wave(3,-3, 1, false), question);
	
	
	var angle = 0;
	var size = 0;
	var x_ = 0;
	var y_ = 0;
	for (var i = 0; i < length; i++)
	{
		var text = new_menu[i];
		var _col = #cb7840;
		
		draw_set_valign(fa_middle);
		if (i == cursor)
		{
			x_ = lengthdir_x(len, ang);
			y_ = lengthdir_y(len, ang);
			text = string_insert("> ", text, 0);
			angle = josh_wave(-2,2, 2, false);
			size = josh_wave(1,1.3, 2, false);
			_col = #c6b282;
		}
		else
		{
			angle = 0;	
			x_ = 0;
			y_ = 0;
			size = 1;
		}
		
		draw_set_font(fnt_frogtype);
		draw_set_color(_col);
		
		x_ += (i * 50);
		draw_set_halign(fa_right);
		draw_text_transformed((final_x + x_) - 50,((initial_y - 30)) + y_, text, size,size, angle);	
		

	}
}