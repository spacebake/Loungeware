event_inherited();

dir = 1;

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