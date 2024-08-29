 /// @description Insert description here
// You can write your code in this editor




tick = 0
  
pattern_array = []
var _layers = layer_get_all()

for (var i = 0; i < array_length(_layers); i++)
{
  
	var _layer = _layers[i]
	var _layer_name = layer_get_name(_layer)
	
	if string_pos("Instances_",_layer_name) > 0
		instance_deactivate_layer(_layer)
	
	if string_pos("Instances_"+string(DIFFICULTY),_layer_name) > 0
	{
		var _pattern = []
		
	
		var _object_array = layer_get_all_elements(_layer)
		
		for (var j = 0; j < array_length(_object_array); j++)
		{
			var _object = 	layer_instance_get_instance(_object_array[j])
			array_push(_pattern, { x: _object.x, y: _object.y, object: _object.object_index, image_xscale: _object.image_xscale })	
			
	
			
		}
		array_push(pattern_array, _pattern)
		
		
	}
}

spawned_count = 0
spawn_next_pattern = function(){
	spawned_count++
	show_debug_message(spawned_count)
	if spawned_count = 3
		var _break = 0
	//instance_create_depth(room_width, random_range(0, room_height),depth, grog_bba_obj_projectile)
	
	var _patterns =  array_shuffle(pattern_array)
	
	var _pattern = _patterns[0]

	for (var i = 0; i < array_length(_pattern); i++)
	{
		
		
		var _inst = _pattern[i]
		var _x = _inst.x
		var _y = _inst.y
		var _object = _inst.object
		
		
		var _spawned_inst = instance_create_depth(room_width+_x, _y, 0, _object, { image_xscale: _inst.image_xscale })
		_spawned_inst.image_xscale = _inst.image_xscale


		if _object = grog_bba_obj_timer
		{

			_spawned_inst.on_done = spawn_next_pattern
		}

	}
	
	
}


spawn_next_pattern()