head_index = irandom_range(1,3);
sprite_index = asset_get_index("mantaray_pool_dive_spr_Player_"+string(head_index));

angle_delta_spd = 1;
velocity_delta_spd = 0.5;

min_initial_velocity = 15;
max_initial_velocity = 35;
initial_velocity = irandom_range(min_initial_velocity, max_initial_velocity); //16

min_angle = 40;
max_angle = 80;
angle = irandom_range(min_angle,max_angle); //45

can_adjust = true;
stop_diving = false;

diving = false;
t_diving = 1;

audio_boing_played = false;
