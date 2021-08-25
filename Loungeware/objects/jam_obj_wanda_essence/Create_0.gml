/// @desc Initialise essence.
global.jamHpPool -= 5;
//global.jamScore -= 3;
targetX = KATSAII_WITCH_WANDA_VIEW_CENTRE_X;
targetY = KATSAII_WITCH_WANDA_VIEW_CENTRE_Y;
var angle = random_range(0, 360);
var mag = random_range(50, 100);
controlX = xstart + lengthdir_x(mag, angle);
controlY = ystart + lengthdir_y(mag, angle);
lifeTimer = 0;
lifeCounter = 0.02;
rot = choose(-1, 1) * choose(1, 2, 4);