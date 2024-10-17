// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_cloud);
part_type_size(_ptype1, .2, 1.1, 0.01, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, .1, .2, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 360, 0, 0, false);
part_type_colour3(_ptype1, $CCCCCC, $AAAAAA, $666666);
part_type_alpha3(_ptype1, 1, 0.271, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 80, 80);

global.grog_bba_smoke = _ptype1




//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_star);
part_type_size(_ptype1, 0.2, .7, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 6, 8, -0.1, 0);
part_type_direction(_ptype1, 80, 180, 0, 0);
part_type_gravity(_ptype1, 0.1, 270);
part_type_orientation(_ptype1, 0, 0, 5, 0, true);
part_type_colour3(_ptype1, $36F2FB, $36F2FB, $36F2FB);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, false);
part_type_life(_ptype1, 30, 80);

global.grog_bba_stars = _ptype1