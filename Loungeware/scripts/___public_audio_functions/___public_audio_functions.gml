// use these to get the game's current volume levels
#macro VOL_SFX ___global.volume_read("sfx")
#macro VOL_MSC ___global.volume_read("msc")
#macro VOL_MASTER ___global.volume_read("master")

// ------------------------------------------------------------------------------------------
// SFX PLAY
// plays a sound effect at the provided volume, relative to the game volume
// returns: unique sound id
// ------------------------------------------------------------------------------------------
/// @function                   sfx_play(_snd, _vol, _loops);
/// @param {sound}  _snd_index  The sound index
/// @param {number}  _vol        The volume relative to the game volume (0-1)
/// @param {bool}   _loop       Whether or not to loop the sound (you can terminate the loop with stop_sfx
/// @description                Plays a sound effect relative to the game volume. Returns Sound ID
function sfx_play(_snd_index, _vol, _loop){
	_vol = _vol * audio_sound_get_gain(_snd_index) * VOL_SFX * VOL_MASTER;
	var _snd_id = audio_play_sound(_snd_index, 0, _loop);
	audio_sound_gain(_snd_id, _vol, 0);
	ds_list_add(___global.___audio_active_list, _snd_id);
	return _snd_id;
}

// ------------------------------------------------------------------------------------------
// SFX STOP
// STOPS a sound effect that is currently playing or looping
// ------------------------------------------------------------------------------------------
/// @function               sfx_stop(_snd, _vol, _loops);
/// @param {sound}  _snd     the unique sound id to stop
/// @param {number}  _time    The time in milseconds it should take to fade the sound out (0 is instant)
function sfx_stop(_snd_id, _time){
	audio_stop_sound(_snd_id);
	audio_sound_gain(_snd_id, 0, _time);
	ds_list_add(___global.___song_stop_list, _snd_id);
}

// ------------------------------------------------------------------------------------------
// MICROGAME MUSIC START
// plays the given song at the correct volume level relative to the game options
// if you want to adjust the volume for a song you added, use the volume slider in the sound asset
// after the song has started you can use microgame_music_stop to stop it.
// this function will also stop the current microgame song if one was already playing.
// returns: unique sound id
// ------------------------------------------------------------------------------------------
/// @function                      microgame_music_start(_sound_index, _loops);
/// @param {sound}  _sound_index    the index of the song to play
/// @param {bool} _loop            whether or not to loop the song
/// @param {number} _vol            volume to play at (0-1).
function microgame_music_start(_sng, _vol, _loop){
	var _snd_id = audio_play_sound(_sng, 0, _loop);
	audio_sound_gain(_snd_id, _vol * audio_sound_get_gain(_sng) * VOL_MSC * VOL_MASTER, 0);
	if (audio_is_playing(___MG_MNGR.microgame_music)) audio_stop_sound(___MG_MNGR.microgame_music);
	___MG_MNGR.microgame_music = _snd_id;
	ds_list_add(___global.___audio_active_list, _snd_id);
	return _snd_id;
}

// ------------------------------------------------------------------------------------------
// MICROGAME MUSIC STOP
// fade out the song which is currently playing, over a given length of time (song will automatically be stopped when the gain reaches 0)
// ------------------------------------------------------------------------------------------
/// @function               microgame_music_stop(_time);
/// @param {number}  _time    the fadeout time in milliseconds.
function microgame_music_stop(_time){
	var _snd_id = ___MG_MNGR.microgame_music;
	audio_sound_gain(_snd_id, 0, _time);
	ds_list_add(___global.___song_stop_list, _snd_id);
	
	return _snd_id;
}

// ------------------------------------------------------------------------------------------
// MICROGAME SFX SET GAIN
// Can be used to change the volume of a sound that is currently playing
// Please use a sound ID for this, not a sound index.
// ------------------------------------------------------------------------------------------
/// @function                      Microgame_sfx_set_gain(_snd_id, _vol, _time);
/// @param {sound}  _snd_id        The index of the song to play
/// @param {number} _vol           The volume to set the gain to (0-1)
/// @param {number} _time          Time in milisconds to change the volume
function microgame_sfx_set_gain(_snd_id, _vol, _time){
	var _sound_index = asset_get_index( audio_get_name(_snd_id) );
	var _mixer_vol = audio_sound_get_gain(_sound_index);
	audio_sound_gain(_snd_id, _vol * _mixer_vol * VOL_SFX * VOL_MASTER, _time);
}

