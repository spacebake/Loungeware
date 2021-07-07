instance_create_layer(
	-16 + instance_number(mimpy_firealarm_obj_tree) * sprite_get_width(mimpy_firealarm_bg_tree),
	room_height,
	"Fire",
	mimpy_firealarm_obj_tree
);
alarm[0] = 20;