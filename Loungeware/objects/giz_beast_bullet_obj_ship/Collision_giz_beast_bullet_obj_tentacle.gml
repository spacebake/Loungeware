if ( giz.game.finished || !other.active ) exit;
giz_beast_bullet_explode(#00D6B3, 20);

sfx_play(giz_beast_bullet_snd_die, 1, 0);
microgame_music_stop(0);

giz.game.set_win(false);
giz.game.finish();