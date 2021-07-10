event_inherited();

snapped = false;

array_push(tweens,
	{
		start: room_height + 100,
		finish: ystart,
		time: 0,
		duration: 30,
		callback: function(_val) { other.y = _val; },
		channel: animcurve_get_channel(mimpy_anim_tweens, "EaseOut")
	}
);

lose = function() {
	microgame_fail();
	snapped = true;
	
	with (mimpy_duckdate_obj_table) {
		array_push(tweens, 
			{
				start: ystart,
				finish: ystart + 10,
				time: 0,
				duration: 20,
				callback: function(_val) { other.y = _val; },
				channel: animcurve_get_channel(mimpy_anim_tweens, "Jump")
			}
		);
	}
	
	with (mimpy_duckdate_obj_duck) {
		image_index = 1;
		array_push(tweens, 
			{
				start: ystart,
				finish: ystart - 30,
				time: 0,
				duration: 20,
				callback: function(_val) { other.y = _val; },
				channel: animcurve_get_channel(mimpy_anim_tweens, "Jump")
			}
		);
		angry = true;
	}
	
	with (mimpy_duckdate_obj_candle) {
		array_push(tweens, 
			{
				start: 0,
				finish: 90 * dir,
				time: 0,
				duration: 20,
				callback: function(_val) { other.image_angle = _val; },
				channel: animcurve_get_channel(mimpy_anim_tweens, "EaseIn")
			}
		);
	}
}