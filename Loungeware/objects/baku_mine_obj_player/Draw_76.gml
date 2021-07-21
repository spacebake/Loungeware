
// Recreate camera (otherwise fov doesn't wanna apply???)
set_camera();

// Camera target
cam.x_from = x;
cam.y_from = y;
cam.z_from = z + eye_height + dsin(head_bob_lerped) * 2;

// Cam pos
cam.x_to = cam.x_from + dcos(-aim_dir) * dcos(aim_pitch);
cam.y_to = cam.y_from + dsin(-aim_dir) * dcos(aim_pitch);
cam.z_to = cam.z_from + dsin(aim_pitch);

// Apply camera
camera_set_view_mat(CAMERA, matrix_build_lookat(cam.x_from, cam.y_from, cam.z_from, cam.x_to, cam.y_to, cam.z_to, cam.x_up, cam.y_up, cam.z_up));
camera_apply(CAMERA);

// Prepare "GUI" surface
if !surface_exists(surf_gui) create_gui_surf();
if surface_exists(surf_gui) {
	surface_set_target(surf_gui);
		
		// Clear
		draw_clear_alpha(c_black, 0.0);
		
		// Debug field of view alignment test
		// draw_sprite(baku_mine_spr_hud_test, 0, 0, 0);
		
		// Thinking bubble
		if think_spawned and !creeper_spawned and !win and !lose {
			var _scale = 3;
			var _think_x = 8 * _scale;
			var _think_y = 4 * _scale;
			var _len = 1 * _scale;
			draw_sprite_ext(baku_mine_spr_think, 0, _think_x + lengthdir_x(_len, (-current_time / 2) + 180),	_think_y +  + lengthdir_y(_len, (-current_time / 2) + 180),					_scale, _scale, 0, c_white, 1);
			draw_sprite_ext(baku_mine_spr_think, 1, _think_x + lengthdir_x(_len, (-current_time / 2) + 90),		_think_y +  + lengthdir_y(_len, (-current_time / 2) + 90),					_scale, _scale, 0, c_white, 1);
			draw_sprite_ext(baku_mine_spr_think, 2, _think_x + lengthdir_x(_len, (-current_time / 2) + 0),		_think_y +  + lengthdir_y(_len, (-current_time / 2) + 0),					_scale, _scale, 0, c_white, 1);
			var _drop_spr = prompt_to_drop_translator[$ PROMPT];
			draw_sprite_ext(_drop_spr, 0, _think_x + lengthdir_x(_len, (-current_time / 2) + 0) + 8 * _scale,	_think_y +  + lengthdir_y(_len, (-current_time / 2) + 0) + 8 * _scale,		_scale, _scale, 0, c_white, 1);
		}
		
		// Continue
		if roundabout_started {
			var _margin = 8;
			var _scale = 3;
			draw_sprite_ext(baku_mine_spr_continue, 0, 480 -_margin, 320 - _margin, _scale, _scale, 0, c_white, 1);
		}
		
		// Reticle
		if !roundabout_started {
			var _scale = 1;
			draw_sprite_ext(baku_mine_spr_reticle, 0, 480/2, 320/2, _scale, _scale, 0, c_white, 1);
		}
		
		// Confetti
		if win {
			var _scale = 3;
			with baku_mine_obj_confetti { draw_sprite_ext(sprite_index, image_index, x, y, _scale, _scale, image_angle, image_blend, image_alpha); }
		}
		
		// Debug variables
		// draw_set_colour(c_white);
		// draw_text(0, 20*0, "difficulty: " + string(DIFFICULTY));
		// draw_text(0, 20*1, "prompt: " + string(PROMPT));
		// draw_text(0, 20*2, "win: " + string(win));
		// draw_text(0, 20*3, "lose: " + string(lose));
		// draw_text(0, 20*4, string(fps) + " " + string(fps_real));
		// draw_text(0, 20*5, string(TIME_REMAINING) + " / " + string(TIME_MAX));
		// draw_text(0, 20*6, string(TIME_REMAINING_SECONDS) + " / " + string(TIME_MAX_SECONDS));
	
	surface_reset_target();
}