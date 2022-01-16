draw_set_font(tfg_fnt_frogtype_72);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_colour(c_gbwhite);

var total_width = string_width("Locate " + string(TFG_GUESS_CURR_PROMPT.name))

draw_text(room_width / 2 - total_width / 2, 100, "Locate ");

draw_text_colour(room_width / 2 - total_width / 2 + string_width("Locate "), 
	100, TFG_GUESS_CURR_PROMPT.name, tfg_c_rainbow, tfg_c_rainbow2, tfg_c_rainbow3, tfg_c_rainbow4, 1);

if (selected && instance_exists(tfg_guess_obj_answer) && abs(tfg_guess_obj_answer.y - tfg_guess_obj_answer.target_y) < 2) {
	var ans_x = tfg_guess_obj_answer.x;
	var ans_y = tfg_guess_obj_answer.y;
	var indicator_x = tfg_guess_obj_indicator.x;
	var indicator_y = tfg_guess_obj_indicator.y;
	
	draw_set_color(won ? tfg_c_green : tfg_c_red);
	draw_dotted_line(ans_x, ans_y, indicator_x, indicator_y, 10, 10);
	
	//draw distance
	var dist = point_distance(ans_x, ans_y, indicator_x, indicator_y);
	var scaled_dist = dist * TFG_GUESS_MILE_SCALE
	draw_set_colour(tfg_c_black);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	var xx = room_width / 2;
	var yy = room_height - 100;
	draw_text(xx, yy, "Off by " + string(scaled_dist) + " miles");
	
	//var dir = point_direction(ans_x, ans_y, indicator_x, indicator_y);
	//var xx = ans_x + lengthdir_x(dist / 2, dir);
	//var yy = ans_y + lengthdir_y(dist / 2, dir);
	//draw_set_halign(fa_left);
	//draw_set_valign(fa_top);
	//draw_set_font(tfg_fnt_frogtype_12);
	//draw_text_transformed(xx + lengthdir_x(50, dir + 180), yy + lengthdir_y(50, dir + 180), 
	//	scaled_dist, 1, 1, dir);
	
}