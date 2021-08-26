/// @desc Initialise the skyline.
partSys = part_system_create_layer(layer, true);
partSysCloud = part_system_create_layer(layer, true);
part_system_automatic_draw(partSys, false);
part_system_automatic_draw(partSysCloud, false);
part_system_automatic_update(partSys, false);
part_system_automatic_update(partSysCloud, false);
cloudTimer = 1;
cloudCountdown = 0.01;
islandTimer = random_range(0.2, 0.8);
islandCountdown = 0.0001;