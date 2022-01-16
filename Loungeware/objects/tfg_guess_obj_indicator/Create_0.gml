scale = 0.5;
image_xscale = scale;
image_yscale = scale;

circle_rot_speed = 1;
circle_curr_rot = 0;
circle_w = sprite_get_width(tfg_guess_spr_circle) * scale;
circle_scale = 1 - (DIFFICULTY - 1) * 0.1;

t = 0;
spd = 6;
curr_rot = 0;
target_rot = 0;
max_rot = 25*scale;
curr_yoff = 0;
target_yoff = 0;
max_yoff = 40*scale;
