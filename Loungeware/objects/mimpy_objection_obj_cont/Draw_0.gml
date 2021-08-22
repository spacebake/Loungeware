if (!presenting) {
	var inst = evidence[selection];
	draw_sprite(mimpy_objection_spr_selection, 0, inst.x, inst.y - 64);
}
else {
	for (var i = 0; i < array_length(confetti); i++) {
		var piece = confetti[i];
		piece.y += 1;
		piece.time++;
		
		var angle = 270 + sin(piece.time / 6) * 45;
		var _x = piece.x + lengthdir_x(piece.arc, angle);
		var _y = piece.y + lengthdir_y(piece.arc, angle);
		
		draw_set_color(piece.color);
		draw_line_width(
			_x, _y,
			_x + piece.w, _y + piece.h,
			5
		);
	}
}