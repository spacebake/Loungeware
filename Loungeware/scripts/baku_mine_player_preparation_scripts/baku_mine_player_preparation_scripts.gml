function baku_mine_player_prepare_camera(){
	
	if ( !surface_exists(cam.display) ) cam.display = surface_create(480, 320);

	// Camera target
	cam.x_from = x;
	cam.y_from = y;
	cam.z_from = z + eye_height + dsin(head_bob_lerped) * 2;

	// Cam pos
	cam.x_to = cam.x_from + dcos(-aim_dir) * dcos(aim_pitch);
	cam.y_to = cam.y_from + dsin(-aim_dir) * dcos(aim_pitch);
	cam.z_to = cam.z_from + dsin(aim_pitch);

	// Apply camera
	camera_set_view_mat(cam.cam, 
		matrix_build_lookat(
			cam.x_from, cam.y_from, cam.z_from, 
			cam.x_to, cam.y_to, cam.z_to, 
			cam.x_up, cam.y_up, cam.z_up
		)
	);	
}
