var platform = n8fl_penguin_blast_damsel_weight;
var goal_weight = n8fl_penguin_blast_goal_weight;
var blast_player = n8fl_penguin_blast_player;

if(
	!instance_exists(platform) || 
	!instance_exists(goal_weight) ||
	!instance_exists(blast_player)
){
	exit;	
}

var platform_width = sprite_get_width(platform.sprite_index);
var x1 = platform.x + - platform_width / 2 + run_padding;
var x2 = platform.x + platform_width / 2 - run_padding;


if(blast_player.game_over && blast_player.did_win == false){
	image_angle = 90;
	
	death_offset_y += (40 - death_offset_y) * 0.2;
	y = death_offset_y + lerp(-5, 5, (1+sin(TIME_REMAINING * 0.2))/2);
	x += (platform.x - x) * 0.05;
}else{
	death_offset_y = y;
	if(blast_player.game_over && blast_player.did_win == true){
		if(x > platform.x - platform_width / 2 - run_padding){
			x -= 3;	
		}
	}else{
		var t = ( 1 + sin(((TIME_MAX - TIME_REMAINING) / TIME_MAX) * 30)) / 2;
		var last_x = x;
		x = lerp(x1, x2, t);

		var vx = last_x - x;
		image_xscale = vx > 0 ? 1 : -1;
	}

	y = offset_y + platform.y - 22;

	if(offset_y == 0){
		vy = -jump_force;	
	}

	vy += grav;
	offset_y += vy;

	if(offset_y > 0){
		offset_y = 0;	
	}
}