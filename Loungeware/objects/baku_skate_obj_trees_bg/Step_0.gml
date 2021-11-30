
spd = baku_skate_obj_game.spd * 0.5;

x -= lengthdir_x(spd, dir);
y -= lengthdir_y(spd, dir);

// Off the left side of the screen
if bbox_right < 0 {
	x += 1024*2;
	y += 128*2;
}