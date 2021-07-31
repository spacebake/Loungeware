if (pause_cooldown <= 0 && ___KEY_PAUSE_PRESSED){
	with(instance_create_layer(0, 0, layer, ___obj_pause)){
		gallery_mode = other.gallery_mode;
	};
}
pause_cooldown = max(0, pause_cooldown-1);