#macro game_end ___throw_game_end
#macro ___BUILTIN_GAME_END game_end
function ___throw_game_end() {
	___no_no_throw_with("game_end");
}
#macro audio_play_sound ___throw_audio_play_sound
#macro ___BUILTIN_AUDIO_PLAY_SOUND audio_play_sound
function ___throw_audio_play_sound() {
	___no_no_throw_with("audio_play_sound", "sfx_play");
}
#macro game_load ___throw_game_load
#macro ___BUILTIN_GAME_LOAD game_load
function ___throw_game_load() {
	___no_no_throw_with("game_load");
}
#macro game_save ___throw_game_save
#macro ___BUILTIN_GAME_SAVE game_save
function ___throw_game_save() {
	___no_no_throw_with("game_save");
}


function ___no_no_throw_with(_f_name, _use_instead) {
	var space_approval = "___BUILTIN_" + string_upper(_f_name);
	
	if (_use_instead == undefined)
		throw "You are not allowed to use " + _f_name + ". If you have a really good reason, you can use " + space_approval
	else
		throw "Please use " + _use_instead + " instead of " + _f_name + ". If you have a really good reason, you can use " + space_approval
	
	___BUILTIN_GAME_END();
}












