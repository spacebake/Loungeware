randomize();
image_xscale = 1;
image_speed = 0;
image_index = 0;

draw_time = 0.5;
dead_time =  4/5;//random_range(0.67,4/5);

combo_max = 3;
var game_pieces_num = 2;
combo =  [
	irandom(game_pieces_num),
	irandom(game_pieces_num),
	irandom(game_pieces_num),
]
combo_index = 0;
is_dead = false;
is_win = false;

par_scroll = 0;
start_x = x;

