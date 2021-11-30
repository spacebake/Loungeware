room_goto_after = noone;
object_create_after = noone;

state = "active_check";
substate = 0;
confirmed = false;



function menu_play_lw(){
	state = "fly_up";
	substate = 0;
	larold_frame = 2;
	var _snd_index  = ___snd_larfly;
	var _snd_id = audio_play_sound(_snd_index, 0, 0);
	var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
	audio_sound_gain(_snd_id, _vol, 0);
}


wait = 20;
larold_frame = 0;
step = 0;
larold_y_mod = -8;
larold_vsp = 0;
col_bar = make_color_rgb(43, 36, 56);
col_purp = make_color_rgb(57, 46, 64);
col_close = make_color_rgb(31,27,37);
screenshake = 0;
shake_x = 0;
shake_y = 0;
spotlight_dir = 0;
spotlight_snd = noone;
light_val = 0;
headdir = 0;
fadeout_alpha = 0;
yy_mod = 0;

button_hover = 0;
button_zoomscale = 1;
button_x1 = 0;
button_x2 = 0;
button_y1 = 0;
button_y2 = 0;

// skip straight to title if audio system was already active when load ended
if (audio_system_is_available()){

}
