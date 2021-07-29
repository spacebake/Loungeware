
// Cull blocks in and out
baku_mine_par_block.is_drawn = false;
var _list = ds_list_create();
var _num = instance_place_list(x, y, baku_mine_par_block, _list, false);
if _num > 0 {
	for (var i = 0; i < _num; ++i;) {
		_list[| i].is_drawn = true;
	}
}
ds_list_destroy(_list);