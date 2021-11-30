press_time = max(press_time - 1, 0);
if (KEY_PRIMARY_PRESSED) {
	press_time = grace_period;
}

if (diff >= 2)
	target = base_targets[diff] + (diff / 2) * sin((diff + 1) * current_time / 3000);

frequency = max(frequency + lerp(-frequency / frequency_falloff, frequency_rise, press_time / grace_period), 0);
period = lerp(20, 180, clamp((abs(target - frequency) - 0.5) / 3, 0, 1));

if (abs(frequency - target) < margin) {
	close = true;
	progress = min(progress + 1, duration);
	victory = progress == duration;
}
else {
	close = false;
}

if (victory) {
	microgame_win();
	frequency = target;
}

audio_sound_pitch(oh, 1 + frequency / 5);

layer_sprite_y(arrow, lerp(frame_y + frame_height, frame_y, frequency / 10));
layer_sprite_yscale(singer, 0.9 + 0.1 * sin(current_time / 1000 * 2 * pi));
layer_sprite_angle(singer, 5 * sin(current_time / 1000 * pi));

layer_sprite_y(crowd, crowd_y + 8 + 8 * sin(current_time / 1000 * pi * 2));