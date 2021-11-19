

if !hitshake && floor(image_index) >= hitframe {
	with anti_dungeon_obj_controller {
		enemyshake = 5;	
		enemyhealth_display = enemyhealth;
	}
	hitshake = true;
}