draw_set_text(c_white, tfg_collision_fnt_jetbrains, fa_left, fa_top);
var w = string_width("M");
var h = string_height("M");
var yy = 0;
var j = 0;

for (var i = 0; i < array_length(brokens); i++) {
	var broken = brokens[i];
	
	show_debug_message(broken);
	for (var __j = 0; __j < array_length(broken); { __j++; j++ }) {
		var char = broken[__j];
		
		if (char == "NEWLINE") {
			yy++;
			j = 0;
			continue;
		}
		draw_text(j * w, yy * h, char);
	}
}

if ((t % cursor_flash_delay) > cursor_flash_delay / 2)
	draw_sprite_ext(spr_pixel, 0, cursor_pos.x * w, cursor_pos.y * h, cursor_w, h, 0, c_white, 1);