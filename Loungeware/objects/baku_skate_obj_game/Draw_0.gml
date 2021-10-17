
// -------------------------------------------------------------
//  T H I N G S   A N D   S U C H
// -------------------------------------------------------------

// Trees BACK
with baku_skate_obj_trees_bg event_perform(ev_draw, 0);

// Ground
with baku_skate_obj_ground event_perform(ev_draw, 0);

// Mimpy coords
var _mimpy_x = mimpy_x;
var _mimpy_y = mimpy_y;
_mimpy_x += lengthdir_x(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_x(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);
_mimpy_y += lengthdir_y(sin(wobble_time / (77 / DIFFICULTY)) * 8, 45) + lengthdir_y(cos(wobble_time / (99 / DIFFICULTY)) * 16, world_angle);

// Mimpy shadow
var _shadow_scale = clamp(map(jump_y, 0, -128, 1, 0.5), 0.5, 1);
var _img = grounded ? image_index : 0;
draw_sprite_ext(shadow_sprite, _img, _mimpy_x, _mimpy_y, _shadow_scale, _shadow_scale, 0, c_white, 1);

// Bench
with baku_skate_obj_bench event_perform(ev_draw, 0);

// Mimpy
if sprite_index == baku_skate_spr_mimpy_hit _mimpy_y -= 32;
var _rot = sprite_index == baku_skate_spr_mimpy_hit ? crash_dir : 0;
draw_sprite_ext(sprite_index, image_index, _mimpy_x, _mimpy_y + jump_y, 1, 1, _rot, c_white, 1);

// Dust cloud surface
if !surface_exists(cloud_surf) cloud_surf_create();
if surface_exists(cloud_surf) {
	// Craw particles
	surface_set_target(cloud_surf);
	draw_clear_alpha(c_black, 0);
	with baku_skate_obj_cloud event_perform(ev_draw, 0);
	surface_reset_target();
	
	// Draw surface with outline shader
	var _shader = baku_skate_sh_outline;
	shader_set(_shader);
	var _tex = surface_get_texture(cloud_surf);
	shader_set_uniform_f(shader_get_uniform(_shader, "pixel_h"), texture_get_texel_width(_tex));
	shader_set_uniform_f(shader_get_uniform(_shader, "pixel_w"), texture_get_texel_height(_tex));
	
	var _surf = surface_create(480, 320);
	surface_set_target(_surf);
	draw_clear_alpha(c_black, 0);
	draw_surface(cloud_surf, 0, 0);
	surface_reset_target();
	
	draw_surface(_surf, 0, 0);
	
	surface_free(_surf);
	
	shader_reset();
}

// Trees FRONT
with baku_skate_obj_trees_fg event_perform(ev_draw, 0);

// -------------------------------------------------------------
//  H U D
// -------------------------------------------------------------

// Alarm
if audio_is_playing(baku_skate_snd_alarm) {
	draw_sprite(baku_skate_spr_warning, 0, 480 - 16, 192);
}

// Do a kickflip!!!
if instance_exists(baku_skate_obj_bench) {
	if !crashed and !passed_bench {
		draw_sprite_ext(baku_skate_spr_kickflip_msg, 0, 0, 320, 2, 2, 0, c_white, 1);
	} else if passed_bench {
		draw_sprite_ext(baku_skate_spr_kickflip_msg, 1, 0, 320, 2, 2, 0, c_white, 1);
	} else if crashed {
		draw_sprite_ext(baku_skate_spr_kickflip_msg, 2, 0, 320, 2, 2, 0, c_white, 1);
	}
}

// DEBUG
// draw_set_colour(c_red);
// var _x = 0, _y = 0, _lh = 20;
// draw_text(_x, _y, string(TIME_REMAINING_SECONDS)); _y += _lh;
// draw_text(_x, _y, string(TIME_REMAINING)); _y += _lh;
// draw_text(_x, _y, string(bench_time)); _y += _lh;
// draw_text(_x, _y, string(grav)); _y += _lh;
// draw_text(_x, _y, string(jump_spd)); _y += _lh;
// draw_text(_x, _y, string(crashed)); _y += _lh;
// draw_text(_x, _y, string(collide_y)); _y += _lh;