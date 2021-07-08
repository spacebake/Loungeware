draw_set_text(c_white, tfg_collision_fnt_jetbrains, fa_left, fa_top);
var w = string_width("M");
var h = string_height("M");

var xx = 0;
var yy = 0;
for (var i = 0; i < array_length(broken_code); { i++; yy++; } ) {
	var line = broken_code[i];

	for (var k = 0, xx = 0; k < array_length(line); { k++; xx++; } ) {
		var char = line[k];
		draw_text(w * xx, yy * h, char);
	}
}

if (cursor.drawing)
	draw_sprite_ext(spr_pixel, 0, cursor.x * w, cursor.y * h, cursor.w, h, 0, c_white, 1);