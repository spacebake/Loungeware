/// @description Run the game.


/*
	
			***		Beenade		***
	
			by Nahoo
	
		Beenade is a 10 second game where the player must navigate a bee through a hive.
	
		Controls
			WASD - Move
			E - Sting
			Q - Noclip
	
		Code explaination
			
			Nahoo Runner
				Create - Initialises the grid
				Step - runs the game
				Draw - Draws the game surface (it's done to a surface so you can manipulate it!
	
			generate
				Creates a grid full of walls
				Fills grid with random tiles if not on edge
				cycles 6 times ,running conway's game of life rules to create a smooth structure
				
				finds a player pos
				finds a goal pos
				
				places enemies
				
				fucks off to your mums house ;)
				
			run
				collects player input
				moves player if tile is empty (0) or goal (3)
				processes enemies (moves up or down, if touching lose)
				finds win / lose states
				
			draw
				gets index from every tile
				draws tiles from atlas-ish array
				draws player / enemies independently
				
			reset
				regenerates the map
				
			end
				clears the surface
				sets a finish flag to true
				
				(Ideally, this is where space's code takes over)
				
			Array2D
				creates a 2d array in a script.
				
			log
				It's YAL's favourite - trace!
				
				
			CUM functions
				CUM stands for Complete Useability Monitorer
				
				cum process
					creates floodfill function
					runs function
					makes sure the flood matches with everything
					
					cum (this is the floodfill thing)
						If a tile is already cummed in, exit
						if not, fill it with the target --with cum--
						repeat for adjacent tiles.
						
			Magic Numbers
			0 = empty tile
			1 = wall
			2 = player
			3 = flower
			4+ = enemies
	
*/


#macro Nahoo_WIDTH (480 / 2) / 8
#macro Nahoo_HEIGHT (320 / 2) / 8
#macro Nahoo_iterations 6
#macro Nahoo_atlas [Nahoo_sEmpty, Nahoo_sFull, Nahoo_sGoal, Nahoo_sDark, Nahoo_sHeart]
#macro Nahoo_colours [make_colour_rgb(51, 24, 24), make_colour_rgb(200, 86, 79), make_colour_rgb(241, 161, 96), make_colour_rgb(255, 244, 101)]
#macro Nahoo_DEBUG 0

/*nahoo_beenade_data = 
{
	game_name: "Beenade",
	authors: "Nahoo",
	prompt: "Move!",
	init_room: "nahoo_beenade",
	view_width: 480,
	view_height: 320,
	time_seconds: 10,
	cartridge_col_primary: make_colour_rgb(93, 128, 54),
	cartridge_col_secondary: make_colour_rgb(239, 94, 255),
	cartridge_label: Nahoo_beenade_cartridge,
	interpolation_on: false,
	test_mode: false
}*/

nahoo_surf = surface_create(Nahoo_WIDTH * 8, Nahoo_HEIGHT * 8);
nahoo_orientation = 1;
nahoo_complete = 0;
nahoo_font = undefined;

enemy_count = 2;
enemies = [];
playerPos = { x:0, y:0 };
goalPos = { x:0, y:0 };

nahoo_won = -1;

function nahoo_init()
{
	map = nahoo_generate(Nahoo_WIDTH, Nahoo_HEIGHT, Nahoo_iterations);
	nahoo_verify(map);
	
	enemy_count = 2;
}

function nahoo_generate(w, h, iterations)
{
	//Remember, this is the correct way to spell it
	randomise();
	
	timer = nahoo_timer();
	show_debug_message("generate");
	if(Nahoo_DEBUG) nahoo_log("WARNING - DEBUG MODE IS STILL CURRENTLY ENABLED")
	
	//Creates an initial map, filled fully with walls
	var map = nahoo_Array2D(w, h, 1);
	
	//Cycle through all tiles
	for(var i = 2; i < w - 2; i++)
	{
		for(var j = 2; j < h - 2; j++)
		{
			map[i][j] = (irandom(100) > 60);
		}
	}
	
	//Smooth this shite out, man!
	repeat(iterations)
	{
		var threshold = [5, 6];
		
		for(var i = 1; i < w - 1; i++)
		{
			for(var j = 1; j < h - 1; j++)
			{
				
				// Find all neighbors
				var neighbours = 0;
				for(var o = -1; o <= 1; o++)
				{
					for(var p = -1; p <= 1; p++)
					{
						if ((o != 0 || p != 0) && map[i + o][j + p] == 1)
							neighbours++;
					}
				}
				
				//If not an edge tile, maybe become empty
				if(neighbours >= threshold[0])
					map[i][j] = 1;		
				if(8 - neighbours >= threshold[1])
					map[i][j] = 0;	
			}
		}
	}
	
	// Place player
	do {
		playerPos.x = irandom(w - 2) + 1;
		playerPos.y = irandom(h - 2) + 1;
	} until (map[playerPos.x][playerPos.y] == 0);
	map[playerPos.x][playerPos.y] = 2;
	
	// Place goal
	do {
		goalPos.x = irandom(w - 2) + 1;
		goalPos.y = irandom(h - 2) + 1;
	} until (map[goalPos.x][goalPos.y] == 0);
	map[goalPos.x][goalPos.y] = 3;
	
	// Place enemies
	enemies = [];
	for (var i = 0; i < enemy_count; i++) {
		
		var enemy = {
			num: 4 + i,
			x: 0,
			y: 0,
			hsp: 0,
			vsp: 0
		};
		
		do {
			enemy.x = irandom(w - 4) + 2;
			enemy.y = irandom(h - 4) + 2;
		} until (map[enemy.x][enemy.y] == 0);
		
		// Decide to move in a direction
		var valid_directions = [];
		if (enemy.x != playerPos.x) array_push(valid_directions, false);
		if (enemy.y != playerPos.y) array_push(valid_directions, true);
		
		var hor = valid_directions[irandom(array_length(valid_directions) - 1)];
		enemy.hsp = hor ? choose(-1, 1) : 0;
		enemy.vsp = hor ? 0 : choose(-1, 1);
		
		// Finalize enemy in map
		array_push(enemies, enemy);
		map[enemy.x][enemy.y] = enemy.num;
	}
	
	//Create all the lovely objects :)
	return map;
}

function nahoo_run(m)
{
	if (nahoo_complete && !Nahoo_DEBUG) exit;
	
	var w = array_length(m);
	var h = array_length(m[0]);
	
	if(keyboard_check_pressed(ord("R")) && Nahoo_DEBUG)
	{
		return nahoo_reset();
	}
	
	var check = 
	[
		KEY_UP_PRESSED, //Up
		KEY_DOWN_PRESSED, //Down
		KEY_LEFT_PRESSED, //Left
		KEY_RIGHT_PRESSED, //Right
	];
	
	var pdir = [check[3] - check[2], check[1] - check[0]];
	
	if(m[playerPos.x][playerPos.y] != 2)
	{
		//You fucking died!
		microgame_fail();
		return nahoo_end(0);
		nahoo_log("You died!")
	}
	
	// Move around
	if(pdir[0] != 0 || pdir[1] != 0)
	{
		var destination_x = clamp(playerPos.x + pdir[0], 1, w - 1);
		var destination_y = clamp(playerPos.y + pdir[1], 1, h - 1);
		
		if (m[destination_x][destination_y] == 0 || m[destination_x][destination_y] == 3)
		{
			m[playerPos.x][playerPos.y] = 0;
			m[destination_x][destination_y] = 2;
			playerPos.x = destination_x;
			playerPos.y = destination_y;
			
			sfx_play(Nahoo_sHit, 1, false);
		}
		else if (m[destination_x][destination_y] >= 4)
		{
			m[playerPos.x][playerPos.y] = 0;
			sfx_play(Nahoo_sHit, 1, false);
		}
		
		if (pdir[0] != 0)
		{
			nahoo_orientation = pdir[0];	
		}
	}
	
	//If there isn't a recorded goal pos, it's been stepped on! End the game.
	if (m[goalPos.x][goalPos.y] != 3)
	{
		sfx_play(Nahoo_sWin, 1, false);
		microgame_win();
		return nahoo_end(1);	
	}
	
	timer = max(0, timer - 1);
	if (timer <= 0)
	{
		// Move all enemies
		for (var i = 0; i < enemy_count; i++) {
			var enemy = enemies[i];
			var destination_x = enemy.x + enemy.hsp;
			var destination_y = enemy.y + enemy.vsp;
			
			if (destination_x > 0 && destination_y > 0 && destination_x < w - 1 && destination_y < h - 1 && (m[destination_x][destination_y] == 0 || m[destination_x][destination_y] == 2)) {
				m[destination_x][destination_y] = enemy.num;
				m[enemy.x][enemy.y] = 0;
				
				enemy.x = destination_x;
				enemy.y = destination_y;
				
				sfx_play(Nahoo_sHit, 1, false);
			}
			else {
				enemy.hsp *= -1;
				enemy.vsp *= -1;
			}
		}
		timer = nahoo_timer();
	}
	
	return m;
}

function nahoo_reset()
{
	nahoo_init();	
	if (surface_exists(nahoo_surf)) surface_free(nahoo_surf);
	nahoo_surf = surface_create(Nahoo_WIDTH * 8, Nahoo_HEIGHT * 8);
	
	return map;
}

function nahoo_end(won)
{
	if (surface_exists(nahoo_surf)) surface_free(nahoo_surf);
	nahoo_surf = surface_create(Nahoo_WIDTH * 8, Nahoo_HEIGHT * 8);	
	nahoo_complete = true;
	
	nahoo_won = won;
	
	return nahoo_Array2D(Nahoo_WIDTH, Nahoo_HEIGHT, 0)
}

function nahoo_draw_map(pos, m, arr, xs, ys)
{
	var nc = Nahoo_colours
	
	if(!surface_exists(nahoo_surf)) nahoo_surf = surface_create(Nahoo_WIDTH * 8, Nahoo_HEIGHT * 8);
	
	surface_set_target(nahoo_surf);
	
	for(var i = 0; i < array_length(m); i++)
	{
		for(var j = 0; j < array_length(m[0]); j++)
		{
			switch(m[i][j])
			{
				case 0:
				case 1:
					draw_sprite(arr[m[i][j]], 0, i * 8, j * 8);
				break;
				
				case 2:
					draw_sprite(arr[0], 0, i * 8, j * 8);
				break;
				
				case 3:
					draw_sprite(arr[m[i][j] - 1], 0, i * 8, j * 8);
				break;
				
				case 4:
				case 5:
					draw_sprite(arr[0], 0, i * 8, j * 8);
				break;
			}
		}
	}
	
	draw_set_colour(nc[0]);
	for(var i = 0; i < array_length(m); i++)
	{
		for(var j = 0; j < array_length(m[0]); j++)
		{
			if(m[i][j] == 1)
			{
				if(!(i == 0 || j == 0 || i == array_length(m) - 1 || j == array_length(m[0]) - 1))
				{
					var s =
					[
						m[i][j - 1] == 1,
						m[i][j + 1] == 1,
						m[i - 1][j] == 1,
						m[i + 1][j] == 1
					]
					
					var p = [i * 8, j * 8];
					if(!s[0]) draw_line(p[0] -1, p[1], p[0] + 8, p[1])
					if(!s[1]) draw_line(p[0] -1, p[1] + 8, p[0] + 8, p[1] + 8)
					if(!s[2]) draw_line(p[0], p[1] -1, p[0], p[1] + 8)
					if(!s[3]) draw_line(p[0] + 8, p[1] -1, p[0] + 8, p[1] + 8)
					
				}
			}
		}
	}
	
	draw_set_colour(nc[3]);
	
	draw_set_font(nahoo_font);
	draw_set_colour(c_white);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	//E and S are new characters due to the font, neat right?
	if (!nahoo_complete)
		draw_text(0, 0, "Nahoo E" + string(enemy_count) + "  S" + string(DIFFICULTY))
	
	if (nahoo_won != -1)
	{
		var samplespace = [Nahoo_beenade_lost, Nahoo_beenade_won];
		draw_sprite_ext(samplespace[nahoo_won], 0, pos[0], pos[1], xs, ys , 0, c_white, 1);
	}
	
	
	surface_reset_target();
	
	draw_surface_ext(nahoo_surf, pos[0], pos[1], xs, ys, 0, c_white, 1);
	
	if(nahoo_won == -1)
	{
		draw_sprite_ext(Nahoo_sBee, 0, (playerPos.x * 8 + 4) * xs, (playerPos.y * 8 + 4) * ys, nahoo_orientation * xs, ys, 0, c_white, 1);
	
		for(var e = 0; e < enemy_count; e++)
		{
			draw_sprite_ext(Nahoo_sWasp, 0, (enemies[e].x * 8 + 4) * xs, (enemies[e].y * 8 + 4) * ys, xs, ys, 0, c_white, 1);
		}
	}
	
}

function nahoo_verify(m)
{
	var foundroute = nahoo_cum_process(m);
	if(!foundroute)
	{
		nahoo_init();
	}
}

function nahoo_cum_process(m)
{
	/*
	Flood-fill (node, target-color, replacement-color):
	 1. If target-color is equal to replacement-color, return.
	 2. ElseIf the color of node is not equal to target-color, return.
	 3. Else Set the color of node to replacement-color.
	 4. Perform Flood-fill (one step to the south of node, target-color, replacement-color).
	    Perform Flood-fill (one step to the north of node, target-color, replacement-color).
	    Perform Flood-fill (one step to the west of node, target-color, replacement-color).
	    Perform Flood-fill (one step to the east of node, target-color, replacement-color).
	 5. Return.
	*/
	
	var walls = 0;
	var playerpos = [0, 0];
	for(var i = 0; i < array_length(m); i++)
	{
		for(var j = 0; j < array_length(m[0]); j++)
		{
			if(m[i][j] == 1)
			{
				walls++;	
			}
			
			if(m[i][j] == 2)
			{
				playerpos = [i, j];	
			}
		}
	}
	
	var empty = ((array_length(m) + 1) * (array_length(m[0]) + 1)) - walls;
	flood = m;
	
	for(var i = 0; i < array_length(m); i++)
	{
		for(var j = 0; j < array_length(m[0]); j++)
		{
			if(flood[i][j] > 1)
			{
				flood[i][j] = 0;	
			}
		}
	}
	
	function nahoo_cum(start, trg, rpl)
	{
		if(trg == rpl)
		{
			return;
		}
		
		if(trg != flood[start[0]][start[1]]) 
		{
			return;
		}
		else
		{
			flood[start[0]][start[1]] = rpl
		}
		 
		if(start[0] - 1 >= 0) nahoo_cum([start[0] - 1, start[1]], trg, rpl)
		if(start[0] + 1 < array_length(flood)) nahoo_cum([start[0] + 1, start[1]], trg, rpl)
		if(start[1] - 1 >= 0) nahoo_cum([start[0], start[1] - 1], trg, rpl)
		if(start[1] + 1 < array_length(flood[0])) nahoo_cum([start[0], start[1] + 1], trg, rpl)
		
		return;
	}
	
	nahoo_cum(playerpos, 0, -1);
	
	var filled = 0;
	for(var i = 0; i < array_length(flood); i++)
	{
		for(var j = 0; j < array_length(flood[0]); j++)
		{
			if(flood[i][j] == -1)
			{
				filled++;	
			}
		}
	}
	
	/*
	
				***		NOTICE		***
				
				This uses the magic number 51 for some reason, i have no fucking clue why this is so broken.
		
	*/
	
	var constant = 51; //CUM just loves 51
	return (empty == filled + constant)
}

function nahoo_Array2D(w, h, def)
{
	var arr = array_create(w, array_create(h, def));
	return arr;
}

function nahoo_log() {

	var str = "";
	
	for(var i = 0; i < argument_count; i++)
	{
		str += string(argument[i]) + " ";
	}
	
	show_debug_message(str);
}

function nahoo_font_generate()
{
	var fontstring = " Naho01234SE"
	nahoo_font = font_add_sprite_ext(Nahoo_sFont, fontstring, false, 0);
}

function nahoo_timer()
{
	return 20; //Magic number? Yes!
}

nahoo_font_generate();


nahoo_init();
