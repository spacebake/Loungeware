function baku_mine_player_draw_begin(){
		
	surface_set_target(cam.display);
	draw_clear_alpha(c_black, 1);
	camera_apply(cam.cam);
	
	baku_mine_shader_3d.set();
	baku_mine_shader_3d.uniform.roundabout_col.set();
	baku_mine_shader_3d.uniform.light_pos.set(light_pos);
	baku_mine_shader_3d.uniform.light_col.set(light_col);
	baku_mine_shader_3d.uniform.light_num.set(light_number);
	baku_mine_shader_3d.uniform.roundabout_active.set(roundabout_started);
	baku_mine_shader_3d.uniform.crack_img.set(0);
	baku_mine_shader_3d.uniform.outline_alpha.set(0);
	baku_mine_shader_3d.uniform.outline_tex.set(sprite_get_texture(baku_mine_spr_highlight, 0));	
	baku_mine_shader_3d.uniform.tex_data.texdata(textures.stone);
	baku_mine_shader_3d.uniform.raw_coord.set(0);
	
}
function baku_mine_player_verify_matrix(_id, _x, _y, _z, _rx, _ry, _rz, _sfac=1){
	if ( matrix[_id] == undefined ) matrix[_id] = matrix_build(_x, _y, _z, _rx, _ry, _rz, scale_x * _sfac, scale_y * _sfac, scale_z * _sfac);
	return matrix[_id];
}
function baku_mine_player_render_blocks() {
	
	call_count = 1;
	
	// Objects	
	gpu_set_cullmode(cull_counterclockwise);
	with ( baku_mine_obj_block_torch ) baku_mine_player_render_torch(other);
	with ( baku_mine_obj_block_ore ) baku_mine_player_render_block(other);
		
	// Reset
	baku_mine_shader_3d.uniform.outline_alpha.set(0);
	baku_mine_shader_3d.uniform.crack_img.set(0);
	baku_mine_shader_3d.uniform.outline_tex.set(sprite_get_texture(baku_mine_spr_highlight, 0));
	
	// Main level
	baku_mine_shader_3d.uniform.raw_coord.set(1);
	draw_vertex_buffer_simple(vb_static, matrix_static, texpage);
	baku_mine_shader_3d.uniform.raw_coord.set(0);
	gpu_set_cullmode(cull_noculling);
	
	// Sign
	with ( baku_mine_obj_block_sign ) baku_mine_player_render_sign(other);
}
function baku_mine_player_render_torch(source){
	source.call_count++
	source.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, texture_name));
	source.draw_vertex_buffer_simple(source.vb_torch, baku_mine_player_verify_matrix(0, x, y, z, 0, 0, image_angle), source.texpage);
}
function baku_mine_player_render_sign(source){
	source.call_count++

	// Sign
	source.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, texture_name));
	source.draw_vertex_buffer_simple(source.vb_cube, baku_mine_player_verify_matrix(0, x, y-13.9, z, 0, 0, image_angle, 0.75), source.texpage);

	// Text
	source.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(source.textures, texture_name_sign_msg));
	source.draw_vertex_buffer_simple(source.vb_plane, baku_mine_player_verify_matrix(1, x, y-7.75, z, 90, 180, image_angle, .5), source.texpage);	

}
function baku_mine_player_render_block(source){
	source.call_count++
	source.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, texture_name));
	
	var _alpha = 0;
	var _image = 0;
	if ( source.block_aim_id == id ) {
		_alpha = .25;
		_image = source.crack_img;
		source.baku_mine_shader_3d.uniform.outline_tex.set(sprite_get_texture(baku_mine_spr_highlight, 1));
	}
	source.baku_mine_shader_3d.uniform.outline_alpha.set(_alpha);
	source.baku_mine_shader_3d.uniform.crack_img.set(_image);
	source.draw_vertex_buffer_simple(source.vb_cube, baku_mine_player_verify_matrix(0, x, y, z, 0, 0, image_angle), source.texpage);
}
function baku_mine_player_render_particles(){
	with ( baku_mine_obj_block_particle ) {
		other.call_count++
		other.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, texture_name));
		other.draw_vertex_buffer(other.vb_cube, pr_trianglelist, other.texpage, x, y, z, 90, 90, dir, scale, scale, scale, matrix_world);
	}	
}
function baku_mine_player_render_items(){
	with ( baku_mine_obj_drop ) {
		
		// Shadow (this has alpha... drawing it now feels dirty but eh, let's just pray to the gods it doesn't mess with anything)
		//var _scale = 0.5;
		//other.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, "drop_shadow"));
		//other.draw_vertex_buffer(other.vb_plane, pr_trianglelist, other.texpage, x, y, z_og - 8 + 0.1, 0, 0, 0, _scale, _scale, _scale, matrix_world);
		other.call_count++
		var _scale = 0.333;
		other.baku_mine_shader_3d.uniform.tex_data.texdata(variable_struct_get(other.textures, texture_name));
		other.draw_vertex_buffer(other.vb_plane, pr_trianglelist, other.texpage, x, y, z_draw, 90, 90, current_time / 5, _scale, _scale, _scale, matrix_world);
	}	
}
function baku_mine_player_render_pickaxe(){
	
	// Pickaxe
	call_count++
	var _scale = 2;
	var _len_front = 40;
	var _len_side = 32;
	var _len_down = 16;
	baku_mine_shader_3d.uniform.tex_data.texdata(textures.pickaxe);
	draw_vertex_buffer(
		vb_plane,
		pr_trianglelist,
		texpage,
		x + (dcos(-aim_dir) * _len_front) + (dcos(-aim_dir + 90) * _len_side),
		y + (dsin(-aim_dir) * _len_front) + (dsin(-aim_dir + 90) * _len_side),
		z - _len_down,
		135 - dsin(pick_rot_lerped) * 45,
		90,
		aim_dir - 60,
		_scale,
		_scale,
		_scale,
		matrix_world
	);	
	gpu_set_ztestenable(true);
	
}
function baku_mine_player_render_creeper(){
	
	gpu_set_ztestenable(false);
	if ( !creeper_spawned ) return;
	
	gpu_set_cullmode(cull_counterclockwise);
		if ( show_alt_creeper ) baku_mine_player_render_creeper_alt();
		else baku_mine_player_render_creeper_main();
	gpu_set_cullmode(cull_noculling);
	
}
function baku_mine_player_render_creeper_main(){
	
	call_count++
	var _scale = 0.4;
	var _len_front = 40;
	
	baku_mine_shader_3d.uniform.tex_data.texdata(textures.creeper_body);
	draw_vertex_buffer(
		vb_cube,
		pr_trianglelist,
		texpage,
		x + (dcos(-creeper_aim_dir) * _len_front),
		y + (dsin(-creeper_aim_dir) * _len_front),
		cam.z_from - 24,
		0,
		0,
		creeper_aim_dir,
		_scale,
		_scale,
		1,
		matrix_world
	);
			
	// Creeper head
	call_count++
	var _scale = 0.5;
	baku_mine_shader_3d.uniform.tex_data.texdata(textures.creeper_face);
	draw_vertex_buffer(
		vb_cube,
		pr_trianglelist,
		texpage,
		x + (dcos(-creeper_aim_dir) * _len_front),
		y + (dsin(-creeper_aim_dir) * _len_front),
		cam.z_from,
		0,
		0,
		aim_dir - 90,
		_scale,
		_scale,
		_scale,
		matrix_world
	);
}
function baku_mine_player_render_creeper_alt(){
	call_count++
	var _scale = 2;
	var _len_front = 40;
	baku_mine_shader_3d.uniform.tex_data.texdata(textures.creeper_alt);
	draw_vertex_buffer(
		vb_plane,
		pr_trianglelist,
		texpage,
		x + (dcos(-creeper_aim_dir) * _len_front),
		y + (dsin(-creeper_aim_dir) * _len_front),
		cam.z_from - 20,
		90,
		90,
		aim_dir,
		_scale,
		_scale,
		_scale,
		matrix_world
	);	
}
function baku_mine_player_render_end(){
	shader_reset();
	surface_reset_target();
	
	matrix_set(matrix_world, i_matrix);	
	draw_surface(cam.display, 0, 0);
}
function baku_mine_player_render_gui(){

	// Reticle
	var _scale = 1;
	if ( !roundabout_started ) {
		draw_sprite_ext(baku_mine_spr_reticle, 0, 480/2, 320/2, _scale, _scale, 0, c_white, 1);
	} else {
		var _margin = 8;
		var _scale	= 3;
		draw_sprite_ext(baku_mine_spr_continue, 0, 480 -_margin, 320 - _margin, _scale, _scale, 0, c_white, 1);	
	}
		
	// Confetti
	if ( win ) {
		var _scale = 3;
		with baku_mine_obj_confetti { draw_sprite_ext(sprite_index, image_index, x, y, _scale, _scale, image_angle, image_blend, image_alpha); }
	}
		
	// Debug guff
	if ( false ) {
		draw_set_color(c_gbwhite);
		var _x = 0, _y = 0, _lh = 20;
		draw_text(_x, _y, string(fps) + " " + string(fps_real) + "\nDRAW CALLS: "+string(call_count)); _y += _lh;
		// draw_text(_x, _y, "13:54"); _y += _lh;
		// draw_text(_x, _y, "parts: " + string(instance_number(baku_mine_obj_block_particle))); _y += _lh;
		// draw_text(_x, _y, "win: " + string(win)); _y += _lh;
		// draw_text(_x, _y, "lose: " + string(lose)); _y += _lh;
		// draw_text(_x, _y, string(TIME_REMAINING) + " / " + string(TIME_MAX)); _y += _lh;
		// draw_text(_x, _y, string(TIME_REMAINING_SECONDS) + " / " + string(TIME_MAX_SECONDS)); _y += _lh;
		// draw_text(_x, _y, string(timer_skip_time) + " / " + string(timer_skip_threshold)); _y += _lh;
	}
		
	// Prompt
	if ( !creeper_spawned && !win && !lose ) {
		// Setup
		var _shake_x = clamp(prompt_shake, 0, 999) * choose(-1, 0, 1);
		var _shake_y = clamp(prompt_shake, 0, 999) * choose(-1, 0, 1);
		var _prompt_x = prompt_x + _shake_x;
		var _prompt_y = prompt_y + _shake_y;
		var _scale = prompt_scale;
		var _outline_rad = 3 * _scale;
			
		// Draw text
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fnt_frogtype);
		
		// This was doing a lot of damage
		//draw_set_color(c_gbblack);
		//for (var i = 0; i < 360; i += 20) {
		//	draw_text_ext_transformed(
		//		_prompt_x + lengthdir_x(_outline_rad, i), 
		//		_prompt_y + lengthdir_y(_outline_rad, i), 
		//		string_upper(PROMPT) + "!",  16,  480 / 2, _scale, _scale, 0
		//	);
		//}
		draw_set_color(prompt_col);
		draw_text_ext_transformed(_prompt_x, _prompt_y, string_upper(PROMPT) + "!",  16,  480 / 2, _scale, _scale, 0);
			
		// Reset
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_gbwhite);	
	}
}