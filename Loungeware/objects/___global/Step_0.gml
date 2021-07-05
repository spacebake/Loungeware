
// stops songs that are marked for deletion when they hit 0 volume
for (var i = 0; i < ds_list_size(song_stop_list); i++){
	var _sng = song_stop_list[| i];
	var _vol = audio_sound_get_gain(_sng);
	if (_vol <= 0){
		audio_stop_sound(_sng);
		ds_list_delete(song_stop_list, i);
		i--;
	}
}