
if (!sound_played){
	switch (frame){
		case 0: {sfx_play(space_scooter_snd_fail, 1, 0);  break; }
		case 1: {sfx_play(space_scooter_snd_success, 1, 0);break;}
		case 2: {
			sfx_play(space_scooter_snd_success, 1, 0);
			sfx_play(space_scooter_snd_cheer, 1, 0);
			break;
		}
		default: {break;}
	}
	sound_played = true;
}

		

		
