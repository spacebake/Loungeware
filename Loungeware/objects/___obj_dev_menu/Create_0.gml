//# ALLOW banned-functions

camera_set_view_size(CAMERA, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)
surface_resize(application_surface, WINDOW_BASE_SIZE, WINDOW_BASE_SIZE)

state = "intro";
substate = 0;

// skip intro if coming straight from microgame
if (file_exists("skipdevintro.lw")){
	file_delete("skipdevintro.lw");
	state = "skip";
}

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
	confirmed = false;
}

cursor = 0;
confirmed = false;
menu = [
	["I WANNA PLAY LOUNGEWARE!", menu_play_lw],
	["I WANNA TEST MY MICROGAME!", menu_goto_gamelist]
]

game_keylist =  ___microgame_get_keylist_chronological();
cursor2 = 0;
cart_sprite = noone;
surf_cart = noone;
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
confirm_shake_time_max = 15;
confirm_shake_time = confirm_shake_time_max;
larold_y_mod = -8;
larold_vsp = 0;

col_bar = make_color_rgb(43, 36, 56);
col_purp = make_color_rgb(57, 46, 64);
col_close = make_color_rgb(31,27,37);
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

input_cooldown = 0;
input_cooldown_init_max = 17;
input_cooldown_max = 4;
input_is_scrolling = false;
previous_scroll_dir = 0;

scroll_y = 0;
scroll_y_target = 0;
cart_float_dir = 0;

function save_dev_config(_microgame_key){
		if(HTML_MODE){

		} else {
			var _data = {
				microgame_key: _microgame_key,
			}
			var _str = json_stringify(_data);
			var _file = file_text_open_write(___DEV_CONFIG_PATH);
			file_text_write_string(_file, _str);
			file_text_close(_file);
		}
}
