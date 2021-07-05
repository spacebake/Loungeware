


#macro WINDOW_BASE_SIZE ___global.window_base_size_read()

#macro c_magenta ___global.macro_c_magenta
#macro c_gbyellow ___global.macro_c_gbyellow
#macro c_gbpink  ___global.macro_c_gbpink
#macro c_gbblack ___global.macro_c_gbblack
#macro c_gboff ___global.macro_c_gboff
#macro c_gbbacklight ___global.macro_c_gbacklight
#macro c_gbtimer_full ___global.macro_c_gbtimer_full
#macro c_gbtimer_empty ___global.macro_c_gbtimer_empty
#macro c_gbwhite ___global.macro_c_gbwhite
#macro ___cart_primary_col_default ___global.macro_c_cart_primary
#macro ___cart_secondary_col_default ___global.macro_c_cart_secondary
#macro ___cart_label_default johndoe_examplegame_spr_label

#macro SET_TEST_VARS ___global.test_vars = 


/*
// zandy macro hack (as written by tfg, using katro hack)
#macro ds_list_create __ds_list_create
#macro __builtin_ds_list_create ds_list_create
___global.ds_index_list = __builtin_ds_list_create();

function __ds_list_create() {
	var ind = __builtin_ds_list_create();
	// the decimal of 0.1 marks this data structure as a list
	ds_list_add(___global.ds_index_list, ind + 0.1);
	return ind;
}

#macro ds_list_destroy __ds_list_destroy
#macro __builtin_ds_list_destroy ds_list_destroy

function __ds_list_destroy(_ind) {
	_ind = ds_list_find_index(___global.ds_index_list, _ind + 0.1);
	if (_ind != -1) ds_list_delete(___global.ds_index_list, _ind);
	__builtin_ds_map_destroy(_ind);
}*/

