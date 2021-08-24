tm.update();

if (mimpy_objection_obj_cont.evidence[mimpy_objection_obj_cont.selection] == id) {
	time++;
	image_angle = sin(time / 10) * 10;
}
else {
	time = 0;
	image_angle += angle_difference(0, image_angle) / 5;
}