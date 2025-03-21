/// @description Update meter fill

fill_amount = noah_artillery_obj_player.charge;


if (fill_amount == 1)
{
	if (full_charge_timer <= 0)
	{
		show_full_charge = !show_full_charge;
		full_charge_timer = flash_rate;
	}
	else
	{
		full_charge_timer -= 1;
	}
	
	// run timer
}
else
{
	full_charge_timer = 0;
	show_full_charge = false;	
}

