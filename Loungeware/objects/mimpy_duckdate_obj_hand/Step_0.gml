event_inherited();
if (!lost && TIME_REMAINING > 60 && (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED || KEY_RIGHT_PRESSED || KEY_UP_PRESSED || KEY_LEFT_PRESSED || KEY_DOWN_PRESSED)) {
	lost = true;
	
	sfx_play(mimpy_duckdate_snd_steal, 0.8, false);
	array_push(tweens,
		{
			start: 0,
			finish: 180,
			time: 0,
			duration: 30,
			callback: function(_val) {
				other.image_angle = _val;
				if (_val >= 90 && !other.grabbed) {
					other.grabbed = true;
					mimpy_duckdate_obj_food.lose();
					sfx_play(mimpy_duckdate_snd_grab, 0.8, false);
				}
			},
			channel: animcurve_get_channel(mimpy_anim_tweens, "MidSlow")
		}
	);
}