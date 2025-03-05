/// @description Init Variables

// platformer physics
y_speed = 0;
x_speed = 0;
grav = 1;
scroll_speed = 5;
terminal_velocity = 50;
run_speed = 8;
jump_force = 20;
max_air_speed = 12;
air_acceleration = 2;



platform = noah_makimono_obj_stroke_parent;

// jumping
double_jumped = false;
on_ground = true;

microgame_win();