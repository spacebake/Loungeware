if (dev_mode){
	if (state != "cart_preview"){
		room_goto(___rm_restroom);
		___state_change("cart_preview");
	} else {
		game_restart();
	}
}