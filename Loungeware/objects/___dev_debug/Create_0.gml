// load temp env
saved_dev_vars = ___dev_load();
___global.difficulty_level = saved_dev_vars.difficulty_level;

debug_hidden = saved_dev_vars.debug_hidden;
muted = saved_dev_vars.mute_test;
audio_set_master_gain(0, !muted);

infinite_timer = saved_dev_vars.infinite_timer;

shake_timer = 0;
shake_timer_max = 20;
if (DIFFICULTY > 1) shake_timer = shake_timer_max;

