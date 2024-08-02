/// @description
timer = -60;
length = 30;
offset = 20;
curve = animcurve_get_channel(pixpope_hp_ac_blessed, 0);
ystart = room_height+sprite_height;
y=ystart;
x = room_width / 2;
var _ps = part_system_create_layer("BlessedParticles");

//Emitter
var _ptype1 = part_type_create();
part_type_shape(_ptype1, pt_shape_flare);
part_type_size(_ptype1, 0.5, 1.5, 0.01, .75);
part_type_scale(_ptype1, .5, .5);
part_type_speed(_ptype1, .5, 3, 0.01, 0.2);
part_type_direction(_ptype1, 80, 100, 0, 5);
part_type_gravity(_ptype1, 0, 270);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $CCFAFF, $B2FFFD, $FFFFFF);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 60, 160);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, 0, 240, 200, 200, ps_shape_line, ps_distr_linear);
//part_emitter_stream(_ps, _pemit1, _ptype1, -10);

ps = _ps;
type = _ptype1;
emitter = _pemit1;