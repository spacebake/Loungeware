// Inherit the parent event
event_inherited();

image_alpha = 0;
array_push(tweens,
	{
		start: ystart,
		finish: ystart - 30,
		time: 0,
		duration: 45,
		callback: function(_val) {
			other.y = _val;
			var _top = other.ystart - 30;
			var _x =(other.y - _top) / (other.ystart - _top);
			other.image_alpha = -4 * _x * (_x - 1); },
		channel: animcurve_get_channel(mimpy_anim_tweens, "MidSlow")
	}
);