// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pixpope_array_foreach(_array, _callback){
	for(var _i = 0; _i < array_length(_array); _i++){
		_callback(_array[_i], _i);		
	}
}