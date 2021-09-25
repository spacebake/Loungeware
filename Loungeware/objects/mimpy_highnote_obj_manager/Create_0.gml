frequency = 0;
frequency_rise = 0.1;
frequency_falloff = 20;

target = 5;

press_time = 0;
grace_period = 25;

u_texel = shader_get_uniform(mimpy_highnote_sh_split, "texel");
u_uv = shader_get_uniform(mimpy_highnote_sh_split, "uv");
u_split = shader_get_uniform(mimpy_highnote_sh_split, "split");
u_time = shader_get_uniform(mimpy_highnote_sh_split, "time");

amp = 50;
period = 150;
time = 0;

progress = 0;
duration = game_get_speed(gamespeed_fps);

victory = false;

oh = sfx_play(Sound184, 1, true);