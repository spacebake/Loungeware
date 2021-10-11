
// Movement stuff
speeds = [7, 9, 11, 13, 15];
spd = speeds[DIFFICULTY - 1];

// Angle of world
world_angle_x = 1024;
world_angle_y = 128;
world_angle = point_direction(0, 0, world_angle_x, world_angle_y);

// Backgrounds
instance_create_layer(0, 0, layer, baku_skate_obj_bg);
instance_create_layer(1024, 128, layer, baku_skate_obj_bg);
with baku_skate_obj_bg {
	spd = other.spd;
	dir = other.world_angle;
}

// Mimpy coords
mimpy_x_display = 100;
mimpy_y_display = 150;
