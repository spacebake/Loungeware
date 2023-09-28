if ( --life <= 0 ) next_phase();

subtract_surfaces();
with ( other ) {
	giz_beast_bullet_explode(other.image_blend);
	instance_destroy();
}