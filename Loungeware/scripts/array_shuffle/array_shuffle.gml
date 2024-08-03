function array_shuffle(arr) {
	if (is_array(arr) == false) {
		return arr;	
	}
	
	static _list = __workspace_ds_list_create();
	ds_list_clear(_list);
	for (var _i = 0; _i < array_length(arr); _i++) {
		ds_list_add(_list, arr[_i]);		
	}
	
	ds_list_shuffle(_list);
	
	for (var _i = 0; _i < array_length(arr); _i++) {
		arr[_i] = _list[| _i];	
	}
	
	return arr;
}