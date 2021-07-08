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
	draw_sprite_ext(tfg_collision_spr_pixel, 0, cursor.x * w, cursor.y * h, cursor.w, h, 0, c_white, 1);
	
if (is_edit_menu_draw) {
	var xx = cursor.x * w
	var yy = cursor.y * h
	var x2 = xx + edit_menu_w;
	var y2 = yy + edit_menu_h;
	var my = (yy + y2) / 2;
	var str_w = 0;
	
	nine_slice_box_stretched(tfg_collision_nineslice, xx, yy, x2, y2, 0);
	draw_set_text(c_white, tfg_collision_fnt_frogtype, fa_left, fa_middle);
	for (var i = 0; i < array_length(edit_menu); i++) {
		var draw_at = xx + str_w * i + i * edit_menu_x_pad + edit_menu_x_pad
		
		if (edit_menu_select == i) {
			draw_rectangle_colour(draw_at, yy, draw_at + string_width(edit_menu[i].name), y2, c_white, c_white, c_white, c_white, false);
			
			shader_set(tfg_collision_shd_invert);
			draw_text(draw_at, my, edit_menu[i].name);
			shader_reset();
			
		} else {
			draw_text(draw_at, my, edit_menu[i].name);
		}
		
		str_w = string_width(edit_menu[i].name);
	}
}