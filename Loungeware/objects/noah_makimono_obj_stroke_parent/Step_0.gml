/// @description Insert description here
// You can write your code in this editor


x -= scroll_speed;

// Update width
if (bbox_right > draw_at_x)
{
	draw_width = draw_at_x - bbox_left;
	draw_width = clamp(draw_width, 0, sprite_width);
}
else
{
	draw_width = sprite_width;
}