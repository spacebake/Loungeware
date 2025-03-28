lane_one = 160
lane_two = 230

sprite_change_time = 15;
draw_y_position = y;

stop = false;


//make particles
p_system = part_system_create_layer(layer_get_id("particles"), true);

p_explode = part_type_create();

part_type_sprite(p_explode, tabi_gogogatsby_spr_explosion, true, true, false);
part_type_size(p_explode, 1, 1, 0, 0);
part_type_speed(p_explode, 1, 2, -0.10, 0);
part_type_direction(p_explode, 0, 359, 0, 20);
part_type_life(p_explode, 30, 45);

made_particle = false;
play_sound_once = false;