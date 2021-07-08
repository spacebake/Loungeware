if (y > room_height) exit;

if (other.burning) {
	other.burning = false;
	
	var anyleft = false;
	with (mimpy_loungefire_obj_loungie) {
		if (burning) { anyleft = true; break; }
	}
	if (!anyleft) {
		mimpy_loungefire_obj_bucket.onWin();
		microgame_win();
	}
	instance_destroy();
}