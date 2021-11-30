var height = lerp(0, frame_height, margin / 20);

draw_set_color(close ? c_green : c_red);
var pos = lerp(frame_y + frame_height, frame_y, target / 10);
draw_rectangle(frame_x, pos - height, frame_x + frame_width, pos + height, false);

//draw_set_color(c_white);
//var pos = lerp(frame_y + frame_height, frame_y, frequency / 10);
//draw_rectangle(frame_x, pos - height, frame_x + frame_width, pos + height, false);

var tex = sprite_get_texture(sprite_index, 0);
var texel_w = texture_get_texel_width(tex);
var texel_h = texture_get_texel_width(tex);
var uvs = sprite_get_uvs(sprite_index, 0);
shader_set(mimpy_highnote_sh_split);
shader_set_uniform_f(u_texel, texel_w, texel_h);
shader_set_uniform_f(u_uv, uvs[0], uvs[1], uvs[2], uvs[3]);
shader_set_uniform_f(u_split, lerp(amp, 0, progress / duration), period);
shader_set_uniform_f(u_time, 5 * current_time / 1000);
draw_sprite(sprite_index, 0, x, y);
shader_reset();