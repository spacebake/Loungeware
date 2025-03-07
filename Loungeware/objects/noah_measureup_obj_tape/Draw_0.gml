/// @description Insert description here
// You can write your code in this editor

draw_self();

// Draw line
draw_set_color(red);
if (droppable)
{
	draw_set_color(green);	
}
if (!block_dropped)
{
	var _spacing = 25;
	var _startY = y;
	var _endY = _startY + _spacing;
	var _reachedBottom = false;
	while(!_reachedBottom)
	{
		draw_line_width(x, _startY, x, _endY, 2);
		_startY += 2 * _spacing;
		_endY += 2 * _spacing;
		if (_endY > room_height)
		{
			_reachedBottom = true;	
		}
	}
	
}

if (arrow_showing)
{
	draw_sprite(noah_measureup_spr_arrow, 0, arrow_x, arrow_y);	
}
