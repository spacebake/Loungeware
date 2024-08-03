global.___array_shuffle_list = ds_list_create();

function array_shuffle(arr) {
	if (is_array(arr) == false) {
		return arr;	
	}
	
	ds_list_clear(global.___array_shuffle_list);
	for (var _i = 0; _i < array_length(arr); _i++) {
		ds_list_add(global.___array_shuffle_list, arr[_i]);		
	}
	
	ds_list_shuffle(global.___array_shuffle_list);
	
	for (var _i = 0; _i < array_length(arr); _i++) {
		arr[_i] = global.__array_shuffle_list[| _i];	
	}
	
	return arr;
}