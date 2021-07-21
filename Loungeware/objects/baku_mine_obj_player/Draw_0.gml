
// Enable 3D + shader
enable_3d();
var _shader = baku_mine_sh_3d_lighting;
shader_set(_shader);

	// Uniforms
	shader_set_uniform_f(shader_get_uniform(_shader, "room_size"), room_width, room_height);
	shader_set_uniform_f(shader_get_uniform(_shader, "highlight_alpha"), 0);
	shader_set_uniform_f_array(shader_get_uniform(_shader, "light_pos"), light_pos);
	shader_set_uniform_f_array(shader_get_uniform(_shader, "light_col"), light_col);
	
	// Textures
	texture_set_stage(shader_get_sampler_index(_shader, "texture_highlight"), sprite_get_texture(baku_mine_spr_highlight, 0));
	texture_set_stage(shader_get_sampler_index(_shader, "texture_crack"), sprite_get_texture(baku_mine_spr_crack, 0));
	
	// Blocks
	var _vb_cube = vb_cube;
	var _vb_torch = vb_torch;
	var _vb_plane = vb_plane;
	with baku_mine_par_block {
		
		// Set highlight alpha + crack
		var _highlight_alpha = 0;
		var _crack_img = 0;
		if other.block_aim_id == id {
			_highlight_alpha = 0.25;
			_crack_img = other.crack_img;
		}
		shader_set_uniform_f(shader_get_uniform(_shader, "highlight_alpha"), _highlight_alpha);
		texture_set_stage(shader_get_sampler_index(_shader, "texture_crack"), sprite_get_texture(baku_mine_spr_crack, _crack_img));
		
		// Model
		var _model = _vb_cube;
		if model_type == "torch" _model = _vb_torch;
		
		// Draw model
		if model_type == "sign" {
			// Sign
			other.draw_vertex_buffer(_vb_cube, pr_trianglelist, sprite_get_texture(tex, 0), x, y - 14, z + 1, 0, 0, image_angle, scale_x, scale_y, scale_z * 0.5, matrix_world);
			// Text
			other.draw_vertex_buffer(_vb_plane, pr_trianglelist, sprite_get_texture(baku_mine_spr_goofed, 0), x, y - 6 + 0.1, z + 1, 90, 180, image_angle, scale_x * 0.5, scale_y * 0.5, scale_z * 0.5, matrix_world);
		} else {
			other.draw_vertex_buffer(_model, pr_trianglelist, sprite_get_texture(tex, 0), x, y, z, 0, 0, image_angle, scale_x, scale_y, scale_z, matrix_world);
		}
	}
	
	// Reset highlight alpha
	shader_set_uniform_f(shader_get_uniform(_shader, "highlight_alpha"), 0);
	
	// Item drops
	with baku_mine_obj_drop {
		var _scale = 0.5;
		other.draw_vertex_buffer(_vb_plane, pr_trianglelist, sprite_get_texture(baku_mine_spr_drop_shadow, 0), x, y, z_og - 8 + 0.1, 0, 0, 0, _scale, _scale, _scale, matrix_world);
		var _scale = 0.333;
		other.draw_vertex_buffer(_vb_plane, pr_trianglelist, sprite_get_texture(tex, 0), x, y, z_draw, 90, 90, current_time / 5, _scale, _scale, _scale, matrix_world);
	}
	
	// Alpha stuffs
	
	// Item drops
	// with baku_mine_obj_drop {
	// }
	
	// Disable z testing
	gpu_set_ztestenable(false);
	
	// Pickaxe
	var _scale = 2;
	var _len_front = 40;
	var _len_side = 32;
	var _len_down = 16;
	draw_vertex_buffer(
		vb_plane,
		pr_trianglelist,
		sprite_get_texture(baku_mine_spr_pick, 0),
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

// Draw "GUI"
// lmao this is the dumbest fucking shit I've ever done BUT IT WORKS
if surface_exists(surf_gui) {
	shader_set(baku_mine_sh_billboard);
	var _len = 2;
	// gui_scale_x += (keyboard_check_pressed(ord("H")) - keyboard_check_pressed(ord("G"))) * 0.0001;
	// gui_scale_y += (keyboard_check_pressed(ord("N")) - keyboard_check_pressed(ord("B"))) * 0.0001;
	// show_debug_message("gui_scale: " + string(gui_scale_x*1000) + " , " + string(gui_scale_y*1000) + " , " + string(gui_scale_z*1000));
	draw_vertex_buffer(
		vb_plane,
		pr_trianglelist,
		// sprite_get_texture(baku_mine_spr_hud_test, 0),
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

// THIS FEELS LIKE A DIRTY HACK??? but i don't fucking know how else to get my GUI to draw lmao
CAMERA = camera_get_default();