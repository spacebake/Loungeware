
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
if !surface_exists(surf_gui) {
	create_gui_surf();
}
if surface_exists(surf_gui) {
	surface_set_target(surf_gui);
		
		// Clear
		draw_clear_alpha(c_black, 0.0);
		
		// Size alignment test
		// draw_sprite(baku_mine_spr_hud_test, 0, 0, 0);
		
		// Continue
		// var _margin = 8;
		// var _scale = 3;
		// draw_sprite_ext(baku_mine_spr_continue, 0, _margin, 320 - _margin, _scale, _scale, 0, c_white, 1);
		
		// Reticle
		// var _scale = 1;
		// draw_sprite_ext(baku_mine_spr_reticle, 0, 480/2, 320/2, _scale, _scale, 0, c_white, 1);
	
	surface_reset_target();
}