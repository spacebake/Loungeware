var mx = room_width / 2 - w / 2;
var ty = room_height / 2 - 150;

draw_sprite_ext(tfg_collision_spr_pixel, 0, mx, ty, w, top_h, 0, top_c, 1);
draw_set_text(c_white, tfg_collision_fnt_frogtype_24, fa_left, fa_middle);
draw_text(mx + top_pad_left, ty + top_h / 2, "Code Error");

ty += top_h;
draw_set_colour(c_white);
draw_sprite_ext(tfg_collision_spr_pixel, 0, mx, ty, w, main_h, 0, c_white, 1);
draw_set_text(c_black, tfg_collision_fnt_frogtype_24, fa_left, fa_top);
draw_text(mx + main_pad_left, ty + main_pad_top, error);
