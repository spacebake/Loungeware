
var _speedAmp = 2;
spin_speed = 5;


hspeed = random_range(-_speedAmp, _speedAmp)
vspeed = -random(_speedAmp);
image_angle = random(360);
gravity = 0.1;
image_xscale = 0.25 + random(0.75);

var _lifespanFrames= 15;
alarm_set(0, _lifespanFrames);