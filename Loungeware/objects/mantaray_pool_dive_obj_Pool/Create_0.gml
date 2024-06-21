initial_sign = choose(-1,1);
spd = 0.02 * DIFFICULTY;
t = 0;

successful_dive = false;
splash = false;
show_head = false;

part_system = part_system_create_layer("mantaray_pool_dive_lyr_Particles",false);
water = part_type_create();
