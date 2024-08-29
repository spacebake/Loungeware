 /// @description Insert description here
// You can write your code in this editor

tick = 0
   
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
			array_push(_pattern, { x: _object.x, y: _object.y, object: _object.object_index })	
			
	
			
		}
		array_push(pattern_array, _pattern)
		
		
	}
	
	
		
}