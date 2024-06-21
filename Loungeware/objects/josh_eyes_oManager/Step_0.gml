/// @desc
global.campfire_timer--;
global.final_timer--;

if (global.campfire_timer == 0)
{
	sfx_stop(fire_sound);
	sfx_play(josh_eyes_sndFireOut, 1, false);	
}
if (global.campfire_timer == -60)
{
	microgame_music_start(sng_zandy_horror_chase, 0.5, 1);
	create();	
}
if (global.final_timer <= 0)
{
	instance_destroy(josh_eyes_oEye);
	
	ang += circle_speed;
	if (ang >= 360) then ang -= ang;
	
	if (KEY_RIGHT_PRESSED) 
	{
		cursor++;
		if (cursor >= length)
		{
			cursor = 0;
		}
	}
	if (KEY_LEFT_PRESSED)
	{
		cursor--;
		if (cursor < 0)
		{
			cursor = length - 1;	
		}
	}
	
	if (KEY_PRIMARY_PRESSED)
	{
		microgame_music_stop();
		if (new_menu[cursor] == global.right_amount) 
		{
			with (josh_eyes_oLarold) {
				win = true;
			}
			microgame_win(); 
			sfx_play(josh_eyes_sndAplause, 1, false);
			win = true;
		}
		else 
		{
			microgame_fail();
			sfx_play(josh_eyes_sndCrickets, 1, false);
		}
		done = true;
	}
	if (done == false)
	{
		initial_y = lerp(initial_y, final_y, 0.3);
		text_y = lerp(text_y, text_final_y, 0.4);

	}
	else if (done == true)
	{
		initial_y = lerp(initial_y, initial_y - initial_y - 100, 0.3);
		text_y = lerp(text_y, text_y - text_y - 100, 0.4);
		if (created == false)
		{
			repeat(global.right_amount)
			{
				instance_create_layer(0,0, layer, josh_eyes_oEyeDummy);
			}
			created = true;
		}	
	}
}

if (win) then instance_create_layer(random(480),0, layer, josh_eyes_oConfetti);	