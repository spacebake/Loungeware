if (array_length(tweens) > 0) {
	var tween = tweens[0];
	tween.time = min(tween.time + 1, tween.duration);
	tween.callback(lerp(tween.start, tween.finish, animcurve_channel_evaluate(tween.channel, tween.time / tween.duration)));
	
	if (tween.time == tween.duration)
		array_delete(tweens, 0, 1);
}