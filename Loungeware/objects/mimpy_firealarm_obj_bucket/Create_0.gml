max_spd = 4;
accel = 0.2;
hsp = 0;

ammo = 5;
image_speed = 0;

won = false;

onWin = function() {
	layer_set_visible("BackFire", false);
	layer_set_visible("BackgroundBurning", false);
	layer_set_visible("BackgroundCool", true);
	won = true;
	event_perform(ev_alarm, 0);
	
	sfx_play(mimpy_firealarm_win, 1, false);
}