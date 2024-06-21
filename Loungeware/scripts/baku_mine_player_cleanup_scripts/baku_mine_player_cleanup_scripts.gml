function baku_mine_player_cleanup(){
	// Disable 3D
	disable_3d();

	// Delete surfaces
	if ( surface_exists(cam.display ) ) surface_free(cam.display);
	
	// Delete vertex buffers
	vertex_delete_buffer(vb_cube);
	vertex_delete_buffer(vb_torch);
	vertex_delete_buffer(vb_plane);
	vertex_delete_buffer(vb_static);
	
	// Delete format
	vertex_format_delete(format);
	
	// Delete ds lists
	if ( ds_exists(collision_list, ds_type_list) ) ds_list_destroy(collision_list);

}