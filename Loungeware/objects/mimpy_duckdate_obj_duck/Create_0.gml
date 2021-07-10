event_inherited();
array_push(tweens,
	{
		start: room_height + 100,
		finish: ystart,
		time: 0,
		duration: 60,
		callback: function(_val) { other.y = _val; },
		channel: animcurve_get_channel(mimpy_anim_tweens, "BounceOut")
	}
);

time = 0;
time2 = 0;
angry = false;
loved = false;

image_index = 0;
image_speed = 0;