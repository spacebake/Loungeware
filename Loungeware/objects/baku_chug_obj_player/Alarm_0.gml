
// Key images
alarm[0] = key_img_speed;
key_offset = (key_offset == 0) ? 1 : 0;
switch key_offset {
	case 0:
		key_img[0] = key_combo[0];
		key_img[1] = key_combo[1] + key_offset_value;
	break;
	
	case 1:
		key_img[0] = key_combo[0] + key_offset_value;
		key_img[1] = key_combo[1];
	break;
}