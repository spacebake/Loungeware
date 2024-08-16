var keyleft = KEY_LEFT;
var keyright = KEY_RIGHT;
var keyjump = KEY_PRIMARY;

var move = keyright - keyleft;

hsp = move * walksp;

vsp = vsp + grv;

if (place_meeting(x,y+2,rafael_obj_floor)) and (keyjump)
{
	vsp = -8;          
}

if place_meeting(x+hsp,y,rafael_obj_floor)
{
  while (!place_meeting(x+sign(hsp),y,rafael_obj_floor))
  {
    x = x + sign (hsp);
  }
  hsp = 0;
}
x = x + hsp;

if place_meeting(x,y+vsp,rafael_obj_floor)
{
	while (!place_meeting(x,y+sign(vsp),rafael_obj_floor))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}     
y = y + vsp;

if (!place_meeting(x,y+2,rafael_obj_floor))
{
	sprite_index = rafael_spr_rafael_jump_up_right;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
	
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = rafael_spr_rafael_right;
	}
	else
	{
		sprite_index = rafael_spr_rafael_run_right;
	}
}

if (hsp != 0) image_xscale = sign(hsp); 

if DIFFICULTY = 1
{
	if global.fruits_rafaels_fruit_mayhem = 2
	{
		instance_destroy();
		instance_create_layer(x,y,layer,rafael_obj_rafael_victory);
	}
}
if DIFFICULTY = 2
{
	if global.fruits_rafaels_fruit_mayhem = 3
	{
		instance_destroy();
		instance_create_layer(x,y,layer,rafael_obj_rafael_victory);
	}
}
if DIFFICULTY = 3
{
	if global.fruits_rafaels_fruit_mayhem = 4
	{
		instance_destroy();
		instance_create_layer(x,y,layer,rafael_obj_rafael_victory);
	}
}
if DIFFICULTY = 4
{
	if global.fruits_rafaels_fruit_mayhem = 5
	{
		instance_destroy();
		instance_create_layer(x,y,layer,rafael_obj_rafael_victory);
	}
}
if DIFFICULTY = 5
{
	if global.fruits_rafaels_fruit_mayhem = 6
	{
		instance_destroy();
		instance_create_layer(x,y,layer,rafael_obj_rafael_victory);
	}
}