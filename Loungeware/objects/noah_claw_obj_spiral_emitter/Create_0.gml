spin_dir = (spin_clockwise) ? (-1) : (1);

spin_speed = 0.5;
bullet_speed = 12;
frames_per_bullet = 5;
nodes = 4;

// current shot direction
shoot_direction = 0;

// shoot shot
alarm_set(0, frames_per_bullet);