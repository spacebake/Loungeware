depth = -999;

// Target stuff
switch(DIFFICULTY) {
	case 1: TOTAL_TARGETS = 7; break;
	case 2: TOTAL_TARGETS = 9; break;
	case 3: TOTAL_TARGETS = 11; break;
	case 4: TOTAL_TARGETS = 13; break;
	case 5: TOTAL_TARGETS = 14; break;
}
targets_to_make = TOTAL_TARGETS;
targets_hit = 0;
targets_shown = 3;

// Surface stuff
shadow_surface = surface_create(room_width, room_height);
