press_time = max(press_time - 1, 0);
if (KEY_PRIMARY_PRESSED) {
	press_time = grace_period;
}

frequency = max(frequency + lerp(-frequency / frequency_falloff, frequency_rise, press_time / grace_period), 0);
period = lerp(20, 180, clamp((abs(target - frequency) - 0.5) / 3, 0, 1));

if (abs(frequency - target) < 0.5) {
	progress = min(progress + 1, duration);
	victory = progress == duration;
}

if (victory) {
	microgame_win();
	frequency = target;
}

audio_sound_pitch(oh, 1 + frequency / 5);