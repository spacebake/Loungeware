draw_set_text(c_white, tfg_collision_fnt_jetbrains, fa_left, fa_top);
var w = string_width("M");
var h = string_height("M");
var yy = 0;
var j = 0;

var broken = brokens[0];
	
for (var __j = 0; __j < array_length(broken); { __j++; j++ }) {
	var char = broken[__j];
		
	if (char == "NEWLINE") {
		yy++;
		j = -1;
		continue;
	}
	draw_text(j * w, yy * h, char);
}

if (cursor.drawing)
	draw_sprite_ext(spr_pixel, 0, cursor.x * w, cursor.y * h, cursor.w, h, 0, c_white, 1);