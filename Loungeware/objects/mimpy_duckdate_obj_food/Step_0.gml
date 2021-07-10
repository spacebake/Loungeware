// Inherit the parent event
event_inherited();

if (snapped) {
	x = mimpy_duckdate_obj_hand.x + lengthdir_x(108, mimpy_duckdate_obj_hand.image_angle);
	y = mimpy_duckdate_obj_hand.y + lengthdir_y(108, mimpy_duckdate_obj_hand.image_angle);
	image_angle = mimpy_duckdate_obj_hand.image_angle - 90;
}