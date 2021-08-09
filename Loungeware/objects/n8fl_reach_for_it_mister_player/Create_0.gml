randomize();

microgame_music_start(n8fl_reach_for_it_mister_bg_music, 2, 100);

global.n8fl_player = id;

game_over = false;
characters = ds_list_create();

ds_list_add(characters, n8fl_reach_for_it_mister_cpine_spr);
ds_list_add(characters, n8fl_reach_for_it_mister_cnet_spr);
ds_list_add(characters, n8fl_reach_for_it_mister_csahaun_spr);
ds_list_add(characters, n8fl_reach_for_it_mister_cmimps_spr);
ds_list_add(characters, n8fl_reach_for_it_mister_cjosh_spr);
ds_list_add(characters, n8fl_reach_for_it_mister_cmak_spr);

ds_list_shuffle(characters);

get_char = function(){
	var ret = characters[| 0];
	ds_list_delete(characters, 0);
	return ret;
}

draw_time = 4/8;
dead_time =  6.5/8;

var diff = DIFFICULTY;
combo_max = diff < 3 ? 4 : 5;
game_pieces_num = sprite_get_number(n8fl_reach_for_it_mister_btn_prompt_spr)-1;

for(var i = combo_max - 1 ; i >= 0; i--){
	combo[i] = irandom(diff < 3 ? 3 : game_pieces_num-1);	
}

combo_index = 0;
par_scroll_max = 150;
par_speed = 0.05;
par_scroll = 0;

event_inherited();

var size = max(0, ds_list_size(characters)-1);
repeat(size){
	var xx = x + 20 + random(30) * choose(1,-1);
	var yy = y + 6 + random(3) * choose(1,-1);
	var inst = instance_create_depth(xx,yy,depth-yy, n8fl_reach_for_it_mister_spectator);
	inst.sprite_index = get_char();
}

repeat(1) {
	var xx = random_range(200, room_width + 100);
	instance_create_depth(xx, room_height - 20, depth-10, n8fl_reach_for_it_mister_weed);
}

win_sound_played = false;
