if ( --life <= 0 ) next_phase();

subtract_surfaces();
with ( other ) {
	if ( !audio_is_playing(giz_beast_bullet_snd_hit) ) sfx_play(giz_beast_bullet_snd_hit, 1, 0);
	giz_beast_bullet_explode(other.image_blend);
	instance_destroy();
}