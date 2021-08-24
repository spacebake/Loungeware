system = part_system_create_layer(layer_get_id("Instances"), false);

part = part_type_create();
part_type_shape(part, pt_shape_pixel);
part_type_direction(part, 60, 120, 0, 0);
part_type_gravity(part, 0.1, 270);
part_type_speed(part, 0.5, 0.8, 0, 0);
part_type_life(part, 60, 100);

part_particles_create(system, x, y, part, 6);