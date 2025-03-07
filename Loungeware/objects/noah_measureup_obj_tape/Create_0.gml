/// @description Insert description here
// You can write your code in this editor

droppable = true;
block_dropped = false;
arrow_showing = false;

green = make_color_rgb(134, 242, 177);
red = make_color_rgb(242, 144, 134);

// arrow movement
sin_timer = 0;
sin_speed = 15;
arrow_travel = 25;
arrow_x = room_width / 2;
arrow_y_start = room_height / 4;
arrow_y = arrow_y_start;