/// @description Run the game.


/*
	
			***		Cart Type Beat		***
	
			by Nahoo
	
		"Cart Type Beat" is a small rhythm game similar to FNF or DDR!
		It's a 4K rhythm game, so WASD controls or whatever!
	
		Init
			THis is just the create event
			It defined the sunctions for drawing and stepping, purely because i don't like events anymore, and would rather write everything in one place
			
			it creates a tracks, all stored in a struct, the current song is then retrieved from the stricut as a 2D array. This array is 40 entries long (4 entries / second)
			containing an array of 4 bits. Each boolean represents whether an arrow is on this line in the organisation of up, down, left, right
			
		Run
			this increases the current line, "access" every quarter second
			this also checks if a key is pressed, and if this key is currently an arrow on the line, if so, it adds to the successful count
			
			at the end of the track, if at least 40% of arrows were pressed, the player has passsed the game!
			otherwise, they can go fuck off to life-1 land 
			
		Draw 
			THis is kind of strange, as i've reorganised it without getting rid of the obsolete sections
			creates a surface (formerly for stave, arrows and bkg) and draws the bkg to it
			
			draws the face based on if you're passing or not
			uhhh yeah
			
			draws lines and shit, as well as staves and arrows
			I mean really, do you need this described to you? surely not.
			
			
		Tracks
			Track 1 - Main Track
				https://www.beepbox.co/#8n42sbk0l00e02t1Um0a7g0fj07i0r3o331100T0v0L4u00q0d0f8y0z1C2w3c0h0T0v1L2u10q0d0f8y0z1C2w2c0h0T0v0L5u00q1d0f8y0z1C0w3c0h1T0v3L2u12q1d1f7y1z1C0w2c0h2T2v2L4u02q1d1f4y0z2C0w0T2v5L5u02q1d2f4y1zaC0w1b4z000000000ic0000000018M000000000z000000000ic0000000018M00000000p27WFEYslcLoGoKgG0I15O0Iy3PwG0G0IxQSLZvPbKCb1GIFFIFGHFGFFHFGIFGFFLFGHFGFFHFGwaqGqrpaCOOOCCKOCOOOKOgAVakFGHIJKLGrw_7y9DvwAqoIF2E9G0G2qMawCF2E9G0G2qwawCCIa8gGwGwGwGwJwlMJUJglglh1k5kbkbk5k5kgl1l1l45glglh1k5k5kgl1ll4uQaQaQwG2G2Gf80kR-fn89EYeJnTW_W_M8RCnKAOX4P5RioKICIHyGUHyqUHaHaUNvxGUCKaOGOKaHyKaHyIGIHwFou6HyqUHaHaOGOICIH9HaOGOK2FxUqK9HyIGIHyGUHyGUHaHaWij3AQQQISLP9TU5Pq-kW7tlien8llXsvPiqhTU9TWph0mQm05E5sOA0nBp5lBmqcyhkOwelgKlBkbBcN5k4C8AbCG4QpgKjRl2ZlBkbBtlgnkxsRhWGFduiubwDjGbn-LY5jhAAt17ghQ4t17ghQ4t17jsugt-0
	
*/

show_debug_overlay(1)

nahoo_surf = surface_create(Nahoo_WIDTH * 8, Nahoo_HEIGHT * 8);
nahoo_complete = 0;
nahoo_font = undefined;

nahoo_atlas_c = [make_colour_rgb(5, 31, 57), make_colour_rgb(75, 38, 128), make_colour_rgb(197, 59, 157), make_colour_rgb(255, 142, 128)];

surfdom = [480 / 2, 320 / 2];
surf = surface_create(surfdom[0], surfdom[1]);

redraw = true;

inputs = [0, 0, 0, 0];
inputs_held = [0, 0, 0, 0];

//8 notes every 2 seconds!

nahoo_tracks =
{
	track_base:
	[
		[0, 0, 0, 0], //1
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 0, 0],
		[0, 0, 1, 0],
		[0, 0, 0, 0],
		[1, 0, 0, 0],
	
		[0, 0, 0, 1], //2
		[0, 0, 0, 1],
		[0, 0, 0, 1],
		[0, 0, 1, 0],
		[0, 1, 0, 0],
		[1, 0, 0, 0],
		[1, 0, 0, 0],
		[1, 0, 0, 0],
	
		[0, 0, 1, 0], //3
		[0, 1, 0, 0],
		[0, 0, 0, 1],
		[0, 0, 1, 0],
		[0, 1, 0, 0],
		[0, 0, 0, 1],
		[0, 0, 1, 0],
		[0, 1, 0, 0],
	
		[0, 0, 1, 0], //4
		[0, 1, 0, 0],
		[0, 0, 0, 1],
		[0, 0, 1, 0],
		[0, 1, 0, 0],
		[0, 0, 0, 1],
		[0, 1, 0, 0],
		[0, 0, 1, 0],
	
		[1, 0, 0, 0], //5
		[1, 0, 0, 0],
		[1, 0, 0, 0],
		[1, 0, 0, 0]
	]
}

nahoo_track = nahoo_tracks.track_base;


interval = room_speed / 4;
timer = interval;

access = 0;

total = 0;
acceptable = 0;

successful = 0;

for(var i = 0; i < array_length(nahoo_track); i++)
{
	for(var j = 0; j < array_length(nahoo_track[i]); j++)
	{
		total += nahoo_track[i][j];	
	}
}

acceptable = total * 0.4;

show_debug_message([acceptable, total])

function nahoo_run_c()
{
	timer = max(0, timer - 1);
	
	if(!timer)
	{
		if(access <= array_length(nahoo_track) - 1)
		{
			access++;
			timer = interval;
		}
		else
		{
			
			if(acceptable <= successful)
			{
				microgame_win();
			}
			else
			{
				microgame_fail();	
			}
		}
	}
	
	if(access <= array_length(nahoo_track) - 1)
	{
		inputs = 
		[
			KEY_UP_PRESSED,
			KEY_DOWN_PRESSED,
			KEY_LEFT_PRESSED,
			KEY_RIGHT_PRESSED
		];
		
		inputs_held = 
		[
			KEY_UP,
			KEY_DOWN,
			KEY_LEFT,
			KEY_RIGHT
		];
	
		var retrieve = nahoo_track[access];
	
		for(var i = 0; i < array_length(retrieve); i++)
		{
			if(retrieve[i] && inputs[i])
			{
				nahoo_track[access][i] = -1;
				successful++;
			}
		}
	}
}

function nahoo_draw_c()
{
	if(!surface_exists(surf))
	{
		surf = surface_create(surfdom[0], surfdom[1]) 
		redraw = true;
	}
	
	var padding = surfdom[0] * 0.3, // Micro optimised!
			separation = (surfdom[0] - padding) / 5;
	
	if(redraw)
	{
		surface_set_target(surf);
		
		//Draw BKG
		draw_set_colour(nahoo_atlas_c[0]);
		draw_rectangle(0, 0, surfdom[0], surfdom[1], 0);
		
		surface_reset_target();
		
		redraw = false;
	}
	
	draw_surface_ext(surf, 0, 0, 2, 2, 0, c_white, 1);

	//Draw the face
	
	var displayscore = round((successful / total) * 100),
		expression = 0;
	
	if(displayscore < 20)  expression = 0;
	if(displayscore >= 20 && displayscore <= 40)  expression = 1;
	if(displayscore >= 40 && displayscore <= 60)  expression = 2;
	if(displayscore >= 60 && displayscore <= 80)  expression = 3;
	if(displayscore > 80)  expression = 4;
	
	var fy = (surfdom[1] * 2 - 32) - (((displayscore / 100) * (surfdom[1] - 32)) * 2);
	
	draw_set_colour(nahoo_atlas_c[3])
	draw_line_width(padding + 16, 0, padding + 16, surfdom[1] * 2, 4);	
	draw_sprite_ext(Nahoo_sArrow, 0, padding + 16, fy, 5, 5, 0, c_white, 1);
	draw_sprite_ext(Nahoo_sFace, 4 - expression, padding + 16, fy, 5, 5, 0, nahoo_atlas_c[3], 1);
			
	for(var i = 0; i < array_length(nahoo_track[0]); i++)
	{
			var s = 5 + (timer / 30) 
			draw_set_colour(nahoo_atlas_c[2])
			
			if(inputs_held[i]) draw_set_colour(nahoo_atlas_c[3])
		
			var lx = padding + (separation * (i + 1));
			draw_line_width(lx * 2, 0, lx * 2, surfdom[1] * 2, 4);	
			
			draw_sprite_ext(Nahoo_sArrow, i + 4, lx * 2, 26 * 2, s, s, 0, c_white, 1);
	}
	
	
	//Draw the upcomers
	
	for(var i = 0; i < 10; i++)
	{
		for(var j = 0; j < array_length(nahoo_track[0]); j++)
		{
			if(array_length(nahoo_track) > i + access)
			{
				if(nahoo_track[access + i][j] == 1)
				{
					var lx = padding + (separation * (j + 1));
					draw_sprite_ext(Nahoo_sArrow, j, lx * 2, (26 + i * 32) * 2, 4, 4, 0, c_white, 1);	
				}
			}
		}
	}
}
