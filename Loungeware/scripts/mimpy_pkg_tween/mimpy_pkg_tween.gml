function mimpy_tween(_start, _finish, _duration, _callback, _type = "Linear", _onEnd = undefined) constructor {
	time = 0;
	
	start = _start;
	finish = _finish;
	duration = _duration;
	callback = _callback;
	type = animcurve_get_channel(mimpy_anim_tweens, _type);
	onEnd = _onEnd;
}

function mimpy_tween_wait(_duration, _onEnd = undefined) constructor {
	time = 0;
	
	start = 0;
	finish = 0;
	duration = _duration;
	callback = undefined;
	type = undefined;
	onEnd = _onEnd;
}

function mimpy_tween_manager() constructor {
	tweens = [];
	
	add = function(_tween) {
		array_push(tweens, _tween);
	}
	
	update = function() {
		if (array_length(tweens) > 0) {
			var tween = tweens[0];
			tween.time = min(tween.time + 1, tween.duration);
			
			if (!is_undefined(tween.callback))
				tween.callback(lerp(tween.start, tween.finish, animcurve_channel_evaluate(tween.type, tween.time / tween.duration)));
	
			if (tween.time == tween.duration) {
				if (!is_undefined(tween.onEnd))
					tween.onEnd();
				array_delete(tweens, 0, 1);
			}
		}
	}
	
	clear = function() {
		tweens = [];
	}
	
	isEmpty = function() {
		return array_length(tweens) == 0;
	}
}