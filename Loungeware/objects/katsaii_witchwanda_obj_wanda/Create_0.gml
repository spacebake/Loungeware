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
flyEmitter = audio_emitter_create();
shootEmitter = audio_emitter_create();
hurtEmitter = audio_emitter_create();
audio_emitter_gain(flyEmitter, 0);
audio_play_sound_on(flyEmitter, katsaii_witchwanda_snd_wanda_fly, true, 100);
part_system_automatic_draw(partSys, false);
part_system_automatic_update(partSys, false);
//show_debug_overlay(true);