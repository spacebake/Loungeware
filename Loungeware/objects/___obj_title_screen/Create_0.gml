camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
step = 0;
state = "intro";
substate = 0;

sng_id = ___BUILTIN_AUDIO_PLAY_SOUND(___sng_zandintro, 0, 1);
var _vol = VOL_MSC * VOL_MASTER * audio_sound_get_gain(___snd_gtr);
audio_sound_gain(sng_id, _vol, 0);

seconds_current = 0;
seconds_prev = 0;

var _tempo = 105;
beat_interval = 60/_tempo;
offbeat_timer = 0;
beat_count = 0;
beat_count_prev = 0;
fast_beat_count = 0;
drum_hit = false;

___microgame_list_remove_incompatible();


// get labels
microgame_namelist = variable_struct_get_names(___global.microgame_metadata);
label_list = ds_list_create();
label_list_2 = ds_list_create();
for (var i = 0; i < array_length(microgame_namelist); i++){
	var _spr = variable_struct_get(___global.microgame_metadata, microgame_namelist[i]).cartridge_label;
	ds_list_add(label_list, _spr);
	ds_list_add(label_list_2, _spr);
}
ds_list_shuffle(label_list);
ds_list_shuffle(label_list_2);


label_scale = 1;
label_speed = 2;
label_count = ds_list_size(label_list);
label_w = sprite_get_width(___cart_label_default) * label_scale;
label_h = sprite_get_height(___cart_label_default) * label_scale;
label_sep = 0;
label_w_total = (label_w + label_sep) * label_count;
label_wait_max = 10;
label_wait = label_wait_max;
label_x = 0;
label_x_min = -label_w_total + WINDOW_BASE_SIZE;
bg_col = make_color_rgb(31, 27, 37);
label_x_snap_target = -(label_w + label_sep);
label_move_delay = 20;
tempo = 80; // 45 steps
ribbon_hide_prog = 1;

//logo
logo_scale = 0;
logo_scale_dir = 0;
trigger_pump = false;

// close
close_circle_prog = 1;
circle_surf = noone;
close_wait = 10;





