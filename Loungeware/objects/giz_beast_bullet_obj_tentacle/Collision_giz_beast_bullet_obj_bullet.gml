if ( wait > 0 ) exit;
with ( other ) giz_beast_bullet_explode(other.image_blend);

if ( --life <= 0 ) {
	if ( !audio_is_playing(giz_beast_bullet_snd_explosion_small) ) sfx_play(giz_beast_bullet_snd_explosion_small, 1, 0);
	instance_destroy();
} else if ( !audio_is_playing(giz_beast_bullet_snd_hit) ) sfx_play(giz_beast_bullet_snd_hit, 1, 0);

if ( !is_face ) wait = 20;
else wait = 30; 