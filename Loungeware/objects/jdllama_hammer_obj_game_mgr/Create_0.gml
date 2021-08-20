chucker = instance_create_layer(x, y, "Chucker", jdllama_hammer_obj_chucker);
isActive = true;
_alarm0 = function() {};
_step = function() {
	
	var angle1 = 228;
	var angle2 = 307;
	if(isActive == true) {
		if(KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED) {
			isActive = false;
			var hammerAngle = chucker.image_angle;
			chucker.image_index = 1;
			chucker.spinMe = false;
			//instance_deactivate_object(chucker);
			if(hammerAngle <= angle2 && hammerAngle >= angle1) {
				microgame_win();
			}
			alarm[0] = 20;
		}
	}
	/*
	var endX = 116;
	var endY = 80;
	
	if (layer_exists("transition")) layer_destroy("transition")
	var _lay = layer_create(-9999,"transition")
	layer_sequence_create(_lay,0,0,_type);	
	*/
}