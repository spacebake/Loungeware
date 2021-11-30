frequency = 0;
frequency_rise = 0.1;
frequency_falloff = 25;

base_targets = [5, 7, 5, 6, 7];
diff = DIFFICULTY - 1;
target = base_targets[diff];

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
duration = game_get_speed(gamespeed_fps) * (1 + (min(DIFFICULTY, 4) - 1) / 4);
margin = lerp(1, 0.75, diff / 4);

victory = false;

oh = sfx_play(mimpy_highnote_snd_note, 1, true);

close = false;

arrow = layer_sprite_get_id("Bar", "mimpy_highnote_graphic_arrow");
singer = layer_sprite_get_id("UI", "mimpy_highnote_graphic_singer");
bubble = layer_sprite_get_id("UI", "mimpy_highnote_graphic_bubble");
crowd = layer_sprite_get_id("Crowd", "mimpy_highnote_graphic_crowd");
crowd_y = layer_sprite_get_y(crowd);

frame = layer_sprite_get_id("UI", "mimpy_highnote_graphic_frame");
frame_x = layer_sprite_get_x(frame) + 13;
frame_y = layer_sprite_get_y(frame) + 5;
var spr = layer_sprite_get_sprite(frame);
frame_width = sprite_get_width(spr) - 16;
frame_height = sprite_get_height(spr) - 8;