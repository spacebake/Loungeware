crane_active = true;
crane_speed = 10;
goal_y = 540;

// win condition
success_y = room_height / 2 - sprite_height;
success = false;
lerp_speed = 0.25; // how fast the claw retreats to the middle after a win
falling = false;
cable_stay_y = 0;

// set reward larold sprite
switch (DIFFICULTY)
{
case 1:
	larold_sprite = noah_claw_spr_larold_1;
	break;
	
case 2:
	larold_sprite = noah_claw_spr_larold_2;
	break;
	
case 3:
	larold_sprite = noah_claw_spr_larold_3;
	break;
	
case 4:
	larold_sprite = noah_claw_spr_larold_4;
	break;
	
case 5:
	larold_sprite = noah_claw_spr_larold_5;
	break;
}
larold_y_offset = sprite_height - 40;