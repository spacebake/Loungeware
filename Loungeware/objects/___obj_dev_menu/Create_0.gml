camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)

state = "intro";
substate = 0;

function menu_play_lw(){
		audio_stop_sound(sng);
		state = "fly_up";
		substate = 0;
		larold_frame = 2;
		var _snd_index  = ___snd_larfly;
		var _snd_id = audio_play_sound(_snd_index, 0, 0);
		var _vol = VOL_SFX * VOL_MASTER * audio_sound_get_gain(_snd_index) * 0.7;
		audio_sound_gain(_snd_id, _vol, 0);
}

function menu_goto_gamelist(){
	state = "goto_gamelist";
}

cursor = 0;
confirmed = false;
menu = [
	["I WANNA PLAY LOUNGEWARE!", menu_play_lw],
	["I WANNA TEST MY MICROGAME!", menu_goto_gamelist]
]

game_keylist =  ___microgame_get_keylist_chronological();


skip_possible = true;

wait = 20;
str_pos = 0;
str_pos_prev = str_pos;
str_final = "HOW'D YOU WANNA\nRUN THE PROJECT?";
str = "";
txt_speed = 0.5;
string_complete = false;
larold_talking = 0;
larold_frame = 0;
step = 0;
confirm_shake_time = 15;
larold_y_mod = -8;
larold_vsp = 0;

col_bar = make_color_rgb(43, 36, 56);
screenshake = 0;
shake_x = 0;
shake_y = 0;

spotlight_dir = 0;

sng = noone;
spotlight_snd = noone;


voice_frames = ds_list_create();
ds_list_add(voice_frames, 17, 35, 45, 58, 65, 73, 83, 92);
flash_frames = ds_list_create();
ds_list_add(flash_frames, 1, 18, 24, 26, 32, 60);

menu_item_x_offset_max = 420;
menu_item_x_offset = menu_item_x_offset_max;

light_val = 0;

headdir = 0;
fadeout_alpha = 0;

yy_mod = 0;