if (y > room_height) exit;

if (other.burning) {
	other.burning = false;
	
	var anyleft = false;
	with (mimpy_firealarm_obj_loungie) {
		if (burning) { anyleft = true; break; }
	}
	if (!anyleft) {
		mimpy_firealarm_obj_bucket.onWin();
		microgame_win();
	}
	repeat(5)
		instance_create_layer(x, y + 24, "Droplet", mimpy_firealarm_obj_droplet_particle);
		
	sfx_play(mimpy_firealarm_douse, 0.5, false);
	instance_destroy();
}