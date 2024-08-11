// sandveech_bg_obj_game.create


#region initialize

	item_list = [
		sandveech_bg_obj_lettuce,
		sandveech_bg_obj_cheese,
		sandveech_bg_obj_tomato,
		sandveech_bg_obj_mayo,
		sandveech_bg_obj_onion,
	];

	order_list = [];
	plate_list = [];

#endregion

check_win	= function() {
	array_sort(order_list, true);
	array_sort(plate_list, true);
	
	return array_equals(order_list, plate_list);
};
clear_game	= function() {
	instance_destroy(sandveech_bg_obj_item);
	instance_destroy(sandveech_bg_obj_arm);	
};

#region difficluty

	add_items = function(_amount) {
		repeat(_amount) {
			if (array_length(item_list) > 0) {
				var _rand = irandom_range(0, array_length(item_list) - 1);
				array_push(order_list, item_list[_rand]);
				array_delete(item_list, _rand, 1);
			}
		}
	};

	switch (DIFFICULTY) {
		case 2:
			add_items(1);
			break;
		case 3:
			add_items(2);
			break;
		case 4:
			add_items(3);
			break;
		case 5:
			add_items(4);
			break;
	}
	
	add_items(2);

#endregion