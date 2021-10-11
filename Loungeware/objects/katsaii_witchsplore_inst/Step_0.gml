/// @desc Update position.
var off_x = xstart - katsaii_witchsplore_player.offX;
var off_y = ystart - katsaii_witchsplore_player.offY;
var axis_x = katsaii_witchsplore_player.vX;
var axis_y = katsaii_witchsplore_player.vY;
x = off_x * axis_x[0] + off_y * axis_y[0];
y = off_x * axis_x[1] + off_y * axis_y[1];
depth = -y;