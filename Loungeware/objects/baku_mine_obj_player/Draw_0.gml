
// Clear alpha to fix html5 jank
draw_clear_alpha(c_black, 1.0);

// Enable 3D + shader
enable_3d();
var _shader = baku_mine_sh_3d;
shader_set(_shader);

// Texture atlas
var _texture = sprite_get_texture(baku_mine_texture, 0);

// Uniforms
shader_set_uniform_f(shader_get_uniform(_shader, "room_size"), room_width, room_height);
shader_set_uniform_f_array(shader_get_uniform(_shader, "light_pos"), light_pos);
shader_set_uniform_f_array(shader_get_uniform(_shader, "light_col"), light_col);
shader_set_uniform_f(shader_get_uniform(_shader, "roundabout_active"), roundabout_started);
var _rb_col = 0x2b75cf;
shader_set_uniform_f(shader_get_uniform(_shader, "roundabout_col"), colour_get_red(_rb_col) / 255, colour_get_green(_rb_col) / 255, colour_get_blue(_rb_col) / 255);
shader_set_uniform_f(shader_get_uniform(_shader, "crack_img"), 0);
shader_set_uniform_f(shader_get_uniform(_shader, "outline_alpha"), 0);

texture_set_stage(shader_get_sampler_index(_shader, "outline_tex"), sprite_get_texture(baku_mine_spr_highlight, 0));

// Default texture
var _tex_data = textures.stone;
shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
	
	// Blocks
	var _vb_cube = vb_cube;
	var _vb_torch = vb_torch;
	var _vb_plane = vb_plane;
	var _outline_alpha = 0;
	var _crack_img = 0;
	with baku_mine_par_block {
		
		// Only draw if it should be drawn.. lol
		if is_drawn {
			var _tex_data = variable_struct_get(other.textures, texture_name);
			shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
			
			// Set highlight alpha + crack
			
			_outline_alpha = 0;
			_crack_img = 0;
			texture_set_stage(shader_get_sampler_index(_shader, "outline_tex"), sprite_get_texture(baku_mine_spr_highlight, 0));
			if other.block_aim_id == id {
				_outline_alpha = 0.25;
				_crack_img = other.crack_img;
				texture_set_stage(shader_get_sampler_index(_shader, "outline_tex"), sprite_get_texture(baku_mine_spr_highlight, 1));
			}
			shader_set_uniform_f(shader_get_uniform(_shader, "outline_alpha"), _outline_alpha);
			shader_set_uniform_f(shader_get_uniform(_shader, "crack_img"), _crack_img);
			
			// Torch
			if model_type == "torch" {
				other.draw_vertex_buffer(_vb_torch, pr_trianglelist, _texture, x, y, z, 0, 0, image_angle, scale_x, scale_y, scale_z, matrix_world);
			}
			
			// Sign
			else if model_type == "sign" {
				// Sign
				other.draw_vertex_buffer(_vb_cube, pr_trianglelist, _texture, x, y - 14, z, 0, 0, image_angle, scale_x * 0.75, scale_y, scale_z * 0.75, matrix_world);
				
				// Text
				var _old_cullmode = gpu_get_cullmode();
				gpu_set_cullmode(cull_noculling);
				var _tex_data = variable_struct_get(other.textures, texture_name_sign_msg);
				shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
				other.draw_vertex_buffer(_vb_plane, pr_trianglelist, _texture, x, y - 6 + 0.1, z, 90, 180, image_angle, scale_x * 0.5, scale_y * 0.5, scale_z * 0.5, matrix_world);
				gpu_set_cullmode(_old_cullmode);
			}
			
			// Normal block
			else {
				other.draw_vertex_buffer(_vb_cube, pr_trianglelist, _texture, x, y, z, 0, 0, image_angle, scale_x, scale_y, scale_z, matrix_world);
			}
		
		}
	}
	
	// Reset highlight alpha
	var _outline_alpha = 0;
	var _crack_img = 0;
	shader_set_uniform_f(shader_get_uniform(_shader, "outline_alpha"), _outline_alpha);
	shader_set_uniform_f(shader_get_uniform(_shader, "crack_img"), _crack_img);
	texture_set_stage(shader_get_sampler_index(_shader, "outline_tex"), sprite_get_texture(baku_mine_spr_highlight, 0));
	
	// Particles
	with baku_mine_obj_block_particle {
		var _tex_data = variable_struct_get(other.textures, texture_name);
		shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
		other.draw_vertex_buffer(_vb_cube, pr_trianglelist, _texture, x, y, z, 90, 90, dir, scale, scale, scale, matrix_world);
	}
	
	// Item drops
	with baku_mine_obj_drop {
		// Shadow (this has alpha... drawing it now feels dirty but eh, let's just pray to the gods it doesn't mess with anything)
		var _scale = 0.5;
		var _tex_data = variable_struct_get(other.textures, "drop_shadow");
		shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
		other.draw_vertex_buffer(_vb_plane, pr_trianglelist, _texture, x, y, z_og - 8 + 0.1, 0, 0, 0, _scale, _scale, _scale, matrix_world);
		var _old_cullmode = gpu_get_cullmode();
		
		// Item
		gpu_set_cullmode(cull_noculling);
		var _scale = 0.333;
		var _tex_data = variable_struct_get(other.textures, texture_name);
		shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
		other.draw_vertex_buffer(_vb_plane, pr_trianglelist, _texture, x, y, z_draw, 90, 90, current_time / 5, _scale, _scale, _scale, matrix_world);
		gpu_set_cullmode(_old_cullmode);
	}
	
	// Disable z testing
	gpu_set_ztestenable(false);
	
	// Creeper
	if creeper_spawned {
		if !show_alt_creeper {
			// Creeper body
			var _scale = 0.4;
			var _len_front = 40;
			var _tex_data = textures.creeper_body;
			shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
			draw_vertex_buffer(
				_vb_cube,
				pr_trianglelist,
				_texture,
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
			var _scale = 0.5;
			var _tex_data = textures.creeper_face;
			shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
			draw_vertex_buffer(
				_vb_cube,
				pr_trianglelist,
				_texture,
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
		} else {
			// "Alternate" creeper (// w //)
			var _scale = 2;
			var _len_front = 40;
			var _tex_data = textures.creeper_alt;
			shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
			draw_vertex_buffer(
				_vb_plane,
				pr_trianglelist,
				_texture,
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
		
	}
	
	// Pickaxe
	var _scale = 2;
	var _len_front = 40;
	var _len_side = 32;
	var _len_down = 16;
	var _tex_data = textures.pickaxe;
	shader_set_uniform_f(shader_get_uniform(_shader, "tex_data"), _tex_data.x, _tex_data.y, _tex_data.w, _tex_data.h);
	draw_vertex_buffer(
		vb_plane,
		pr_trianglelist,
		_texture,
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

// Disable 3D + shader
shader_reset();
disable_3d();

// Draw "GUI" - lmao this is so dumb BUT IT WORKS
if surface_exists(surf_gui) {
	// Shader
	shader_set(baku_mine_sh_billboard);
	shader_set_uniform_f(shader_get_uniform(_shader, "roundabout_active"), roundabout_started);
	var _rb_col = 0x2b75cf;
	shader_set_uniform_f(shader_get_uniform(_shader, "roundabout_col"), colour_get_red(_rb_col) / 255, colour_get_green(_rb_col) / 255, colour_get_blue(_rb_col) / 255);
		// Draw gui plane
		var _len = 2;
		draw_vertex_buffer(
			vb_plane,
			pr_trianglelist,
			surface_get_texture(surf_gui),
			cam.x_from + (dcos(-aim_dir) * dcos(aim_pitch)) * _len,
			cam.y_from + (dsin(-aim_dir) * dcos(aim_pitch)) * _len,
			cam.z_from + dsin(aim_pitch) * _len,
			0,
			0,
			0,
			gui_scale_x*-1,
			gui_scale_y,
			gui_scale_z,
			matrix_world
		);
	
	shader_reset();
}

// Reset matrix
matrix_set(matrix_world, i_matrix);

// At some point I used to have the below line active for the render pipeline to work (idk why) but now it randomly wirks without (idk why)
// If something break, try giving this a poke ????????
// CAMERA = camera_get_default();