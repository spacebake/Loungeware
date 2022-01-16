var hmove = KEY_RIGHT - KEY_LEFT;
var vmove = KEY_DOWN - KEY_UP;

var prev_x = x;
var prev_y = y;

if (!tfg_guess_obj_game.selected) {
	x += hmove * spd;
	y += vmove * spd;
	x = clamp(x, circle_w/2, room_width - circle_w/2);
	y = clamp(y, circle_w/2+200, room_height - circle_w/2);


	if (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
		var inCirc = false;
		var points = TFG_GUESS_CURR_PROMPT.get_points();
	
		for (var i = 0; i < array_length(points); i += 2) {
			if (point_distance(x, y, points[i], points[i+1]) < circle_w/2) {
				inCirc = true;
				break;
			}
		}
	
		if (inCirc) {
			tfg_guess_obj_game.won = true;
			sfx_play(tfg_swipe_snd_succ, 1, false);
		} else {
			sfx_play(tfg_swipe_snd_fail, 1, false);	
		}
	
		var xx = points[0] + (points[2] - points[0]) / 2;
		var yy = points[1] + (points[5] - points[1]) / 2;
		instance_create_layer(xx, yy, layer, tfg_guess_obj_answer);
	
		tfg_guess_obj_game.selected = true;
	}
}


if (prev_x == x) hmove = 0;
if (prev_y == y) vmove = 0;
target_rot = hmove * max_rot;
curr_rot = lerp(curr_rot, target_rot, 0.2);

target_yoff = -vmove * max_yoff;
curr_yoff = lerp(curr_yoff, target_yoff, 0.1);