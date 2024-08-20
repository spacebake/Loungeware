var _part = part_type_create()
global.pixpope_particle_lod_laser_bits = _part;
#macro pixpope_lod_particle_laser_bits global.pixpope_particle_lod_laser_bits

part_type_shape(_part, pt_shape_sphere);
part_type_size(_part, 1, 1, 0, 0);
part_type_scale(_part, .05, .07);
part_type_orientation(_part, 0, 0, 0, 0, 0);
part_type_color3(_part, c_white, c_yellow, c_orange);
part_type_alpha3(_part, .25, .25, 0);
part_type_blend(_part, 0);
part_type_life(_part, 20, 30);
part_type_speed(_part, .1, .20, 0, 0);
part_type_blend(_part, true);
part_type_direction(_part, 0, 360, 0, 0);
part_type_gravity(_part, .2, 180);