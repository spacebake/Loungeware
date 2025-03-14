/// @description Insert description here
// You can write your code in this editor

x -= scroll_speed;

var _guide = noah_measureup_obj_guide_block;
// check if left side of tape is within block
droppable = (bbox_right < _guide.bbox_right + 1 and bbox_right > _guide.bbox_left);

// see block width
var _width = bbox_right - _guide.bbox_left;
if (droppable and !block_dropped)
{
	_guide.image_xscale = _width / 28;
	if (!arrow_showing)
	{
		arrow_showing = true;	
	}
}
else if (_width <= 0 and !block_dropped)
{
	_guide.image_xscale = 0;
	arrow_showing = false;
	microgame_fail();
}

if (!block_dropped and KEY_ANY_PRESSED)
{
	_guide.create_block();
	sfx_play(noah_measureup_sfx_drop, 1.5);
	block_dropped = true;
	arrow_showing = false;
}

// run arrow movement
if (arrow_showing)
{
	if (sin_timer < 360)
	{
		sin_timer += sin_speed;	
	}
	else
	{
		sin_timer = 0;	
	}
	arrow_y = arrow_y_start + arrow_travel * max(0, dsin(sin_timer))
}