/// @desc almost(value1,value2, buffer)
function almost(value, value2, almost_)
{
	return abs(value - value2) <= almost_;
}

function key_free()
{
	return keyboard_check(vk_anykey);	
}

function draw_set_falign(halign,valign)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function array_shuffle(array)
{
	var list = ds_list_create();
	var length = array_length(array);
	var arr = [];
	
	for (var i = 0; i < length; i++)
	{
		list[| i] = array[i];
	}
	ds_list_shuffle(list);
	var ds_size = ds_list_size(list);
	for (var i = 0; i < ds_size; i++)
	{
		array_push(arr, list[| i]);
	}
	ds_list_destroy(list);
	
	return arr;
}

function wave(from, to, duration, offset)
{
	var _wave = (to - from) * 0.5;

	return from + _wave + sin((((current_time * 0.001) + duration * offset) / duration) * (pi * 2)) * _wave;
}

function in_range(range1,range2, value)
{
	return value > range1 && value < range2;
}
