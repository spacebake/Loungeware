/// @description Draw corresponding sprites for key sequence generated 
for (var i = 0; i < key_sequence_length; i++){
	switch(key_sequence[i]){
		case vk_left:
			sprite = spr_button_dpad;
			sprite_subimage = 3;
			x_offset = 0;
			scale = 1;
			break;
			
		case vk_right:
			sprite = spr_button_dpad;
			sprite_subimage = 1;
			x_offset = 0;
			scale = 1;
			break;
			
		case vk_up:
			sprite = spr_button_dpad;
			sprite_subimage = 2;
			x_offset = 0;
			scale = 1;
			break;
			
		case vk_down:
			sprite = spr_button_dpad;
			sprite_subimage = 4;
			x_offset = 0;
			scale = 1;
			break;
			
		case ord("Z"):
			sprite = spr_button_a
			sprite_subimage = 0;
			x_offset = 3;
			scale = 1.5;
			break;
			
		case ord("X"):
			sprite = spr_button_b
			sprite_subimage = 0;
			x_offset = 3;
			scale = 1.5;
			break;
	}
	
	// Draw buttons
	draw_sprite_ext(sprite, sprite_subimage, x + x_offset, y + i * 35, scale, scale, image_angle, sprite_color, sprite_alpha[i]);
}

if (draw_x){ // Draw X sprite when wrong key is pressed
	draw_sprite(chacon_not_enough_tacos_sprite_red_x, 0, x, y + key_count * 35)
}
