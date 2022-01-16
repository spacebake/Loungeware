//goes in the order of a clock starting from top left
//absolute position
function get_points() {
	return [
		x, y,
		x + sprite_width, y,
		x + sprite_width, y + sprite_height,
		x, y + sprite_height,
	];
}