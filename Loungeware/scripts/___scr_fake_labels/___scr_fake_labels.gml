function ___get_fake_label(){
	static _fake_labels = [
		{	// corn on the cop
			cartridge_col_primary: make_color_rgb(55, 24, 72),
			cartridge_col_secondary: make_color_rgb(98, 27, 82),
			img_index: 0,
		},
	];

	var _as_struct =  _fake_labels[irandom(array_length(_fake_labels)-1)];
	return _as_struct;
}

