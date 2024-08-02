/// @description Charge PartSystem

//pixpope_hpsystem_powerup
system = part_system_create();
part_system_depth(system, depth-1);

type = part_type_create();
part_type_shape(type, pt_shape_line);
part_type_size(type, 0, 0.1, 0.01, 0.1);
part_type_scale(type, 1, 0.5);
part_type_speed(type, 0.1, 1, 0.1, 1);
part_type_direction(type, 90, 90, 0, 0);
part_type_gravity(type, 0, 270);
part_type_orientation(type, 0, 0, 0, 0, true);
part_type_colour3(type, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(type, 1, 0.471, 0);
part_type_blend(type, true);
part_type_life(type, 20, 90);

emitter = part_emitter_create(system);
part_emitter_region(system, emitter, -32, 32, 0, 0, ps_shape_line, ps_distr_linear);
part_emitter_stream(system, emitter, type, 0);
part_system_position(system, room_width/2, y+20);



