var xpos = room_width / 2 - 50 + 50 * dsin(current_time);
instance_create_layer(xpos, room_height / 2, "TearInstances", katsaii_witchcraft_tearobj);
alarm[2] = game_get_speed(gamespeed_fps) / 8;