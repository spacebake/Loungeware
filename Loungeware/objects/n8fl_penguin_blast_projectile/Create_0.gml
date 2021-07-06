enum n8fl_penguin_blast_EProjectile{
	Primary,
	Secondary,
	Bomb,
	Length
}
duration = random_range(1.45, 1.55);
start_x = x;
start_y = y;
dest_x = 0;
dest_y = 0;
max_height = random_range(40, 80);
time=0;
image_speed = 0;
has_collided = false;

is_success = false;
is_miss = false;

jump_force = random_range(2,6);
vx = 0
vy = 0;
grav = 0.4;