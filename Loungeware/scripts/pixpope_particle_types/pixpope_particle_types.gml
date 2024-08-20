var _part = part_type_create()
global.pixpope_particle_lod_laser_bits = _part;

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

var _part = part_type_create()
global.pixpope_particle_lod_smoke = _part;
part_type_shape(_part, pt_shape_smoke);
part_type_size(_part, .5, 1.5, 0, 0);
part_type_scale(_part, 1, 1);
part_type_orientation(_part, 0, 360, 0, 5, 0);
part_type_color3(_part, 65535, 33023, 64);
part_type_alpha3(_part, 1, 1, 1);
part_type_blend(_part, 1);
part_type_life(_part, 10, 20);
part_type_speed(_part, 5, 5, 0, 0);
part_type_direction(_part, 0, 360, 0, 0);
part_type_gravity(_part, 1, 180);

var _part = part_type_create()
global.pixpope_particle_lod_fire = _part;
part_type_shape(_part, pt_shape_explosion);
part_type_size(_part, .4, 1, 0, 0);
part_type_scale(_part, 1, 1);
part_type_orientation(_part, 0, 360, 0, 0, 0);
part_type_color3(_part, 0, 5329233, 8421504);
part_type_alpha3(_part, 1, 1, 0);
part_type_blend(_part, 0);
part_type_life(_part, 20, 45);
part_type_speed(_part, .1, 4, 0, 0);
part_type_direction(_part, 135, 215, 0, 0);
part_type_gravity(_part, 0.20, 87);