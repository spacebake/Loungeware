var num = min(DIFFICULTY + 2, 5);
repeat(num) {
	instance_create_layer(irandom_range(0, room_width), room_height + 8, "Loungies", mimpy_firealarm_obj_loungie);
}