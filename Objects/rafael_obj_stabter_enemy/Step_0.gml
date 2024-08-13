vsp = vsp + grv;

if place_meeting(x+hsp,y,rafael_obj_floor)
{
  while (!place_meeting(x+sign(hsp),y,rafael_obj_floor))
  {
    x = x + sign (hsp);
  }
  hsp = -hsp;
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

if (!place_meeting(x,y+1,rafael_obj_floor))
{
	sprite_index = rafael_spr_stabter_crab_enemy;
	image_speed = 0;
	if (sign(vsp) > 0) image_index = 1; else image_index = 0;
	
}
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = rafael_spr_stabter_crab_enemy;
	}
	else
	{
		sprite_index = rafael_spr_stabter_crab_enemy_walking;
	}
}

if (hsp != 0) image_xscale = sign(hsp);