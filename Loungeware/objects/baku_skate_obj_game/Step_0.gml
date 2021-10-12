
// Grav
y_spd += grav;

// Grounded
if jump_y >= 0 {
	jump_y = 0;
	y_spd = 0;
	grounded = true;
	wobble_spd = lerp(wobble_spd, 1, 0.1);
} else {
	grounded = false;
	wobble_spd = lerp(wobble_spd, 0, 0.1);
}

// Jump
if KEY_PRIMARY_PRESSED and grounded {
	y_spd = -jump_spd;
}

// Move y
jump_y += y_spd;

// Mimpy wobble
wobble_time += wobble_spd;