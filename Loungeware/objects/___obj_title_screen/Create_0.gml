camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE);
step = 0;
___state_setup("wait");

wait = 30;
bg_frame = 0;
bg_alpha_multiplier = 0;

sng_id = noone;
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
logo_scale_master = 1;
logo_scale_stored = logo_scale;

logo_scale_dir = 0;
trigger_pump = false;
logo_show_pump = false;
logo_pumpstate = 0;
logo_close_bounce_dir = 0;
logo_end_target = 160;
logo_y =  WINDOW_BASE_SIZE/2;
logo_shake = 0;
logo_draw_last = false;

// close
close_circle_prog = 1;
circle_surf = noone;
close_wait = 10;



bg_x = irandom(VIEW_W);
bg_y = bg_x;
bg_speed = 1;
bg_show = false;
bg_alpha = 0;
bg_y2 = 0;
bg_circle_rad = 240;
bg_shd_surf = noone;

next_beat_prog = 0;

mimpytimer = 60*9; //6
mimpydone = false;

function ___draw_logo(){
	
	// draw logo
	var _logo_x = WINDOW_BASE_SIZE/2;
	var _logo_y = logo_y;
	if (logo_shake > 0){
		var _sv = logo_shake / 2;
		_logo_x += random_range(-_sv, _sv);
		_logo_y += random_range(-_sv, _sv);
	}
	var _spr = ___spr_logo_title;
	var _frame = 0;
	var _alpha = logo_scale;
	var _logo_scale = logo_scale - ((0.1 * (((next_beat_prog-1)/4) / 0.25)) * logo_scale_master);
	logo_scale_stored = _logo_scale;
	if (state == "logo_move"){
		_alpha = 1;
	}
	draw_sprite_ext(_spr, _frame, _logo_x, _logo_y, _logo_scale, _logo_scale, 0, c_white, _alpha);

}

bg_layer = noone;