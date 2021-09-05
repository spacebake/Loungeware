/// @desc Initialise Wanda.
xspeed = 0;
yspeed = 0;
acc = 0.2;
handling = 5;
frict = 2;
partSys = part_system_create_layer(layer, true);
blast = false;
blastTimer = -1;
blastCountdown = 0.25;
blastHeld = 0;
hitTimer = 0;
hitCounter = 0.035;
audio_stop_sound(katsaii_witchwanda_snd_wanda_fly);
flySound = sfx_play(katsaii_witchwanda_snd_wanda_fly, 0, true);
part_system_automatic_draw(partSys, false);
part_system_automatic_update(partSys, false);
//show_debug_overlay(true);