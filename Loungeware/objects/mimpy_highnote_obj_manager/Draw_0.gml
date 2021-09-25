draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(0, 0, frequency);

if (victory) {
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_text_transformed(room_width / 2, room_height, "Nice pipes!", 5, 5, 0);
}

var height = lerp(0, room_height, 0.5 / 10);

draw_set_color(close ? c_green : c_yellow);
var pos = lerp(room_height, 0, target / 10);
draw_rectangle(0, pos - height, room_width, pos + height, false);

draw_set_color(c_white);
var pos = lerp(room_height, 0, frequency / 10);
draw_rectangle(0, pos - height, room_width, pos + height, false);

var tex = sprite_get_texture(mimpy_highnote_spr_note, 0);
var texel_w = texture_get_texel_width(tex);
var texel_h = texture_get_texel_width(tex);
var uvs = sprite_get_uvs(mimpy_highnote_spr_note, 0);
shader_set(mimpy_highnote_sh_split);
shader_set_uniform_f(u_texel, texel_w, texel_h);
shader_set_uniform_f(u_uv, uvs[0], uvs[1], uvs[2], uvs[3]);
shader_set_uniform_f(u_split, lerp(amp, 0, progress / duration), period);
shader_set_uniform_f(u_time, 5 * current_time / 1000);
draw_sprite(mimpy_highnote_spr_note, 0, room_width / 2, room_height / 4);
shader_reset();