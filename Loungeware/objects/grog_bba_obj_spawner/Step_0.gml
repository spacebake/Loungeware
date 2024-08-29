/// @description Insert description here
// You can write your code in this editor

if tick mod 260 = 0 {
	//instance_create_depth(room_width, random_range(0, room_height),depth, grog_bba_obj_projectile)
	
	var _patterns =  array_shuffle(pattern_array)
	
	var _pattern = _patterns[0]

	for (var i = 0; i < array_length(_pattern); i++)
	{
		var _inst = _pattern[i]
		var _x = _inst.x
		var _y = _inst.y
		var _object = _inst.object
		instance_create_depth(room_width+_x, _y, 0, _object)
		
	}
	
	
}


tick++