left_broom = inst_520C8C5D;
right_broom = inst_4C5C16F3;

function _early_tick(){
	if(KEY_PRIMARY){
		right_broom.begin_push();	
	}else if(KEY_SECONDARY){
		left_broom.begin_push();
	}

	if(KEY_UP){
		left_broom.move(-1);
		right_broom.move(-1);
	}

	if(KEY_DOWN){
		left_broom.move(1);
		right_broom.move(1);
	}	
}