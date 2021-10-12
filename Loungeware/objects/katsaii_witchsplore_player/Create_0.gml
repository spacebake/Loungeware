/// @desc Initialise player.
offX = xstart;
offY = ystart;
trailX = offX;
trailY = offY;
vX = [0, 0];
vY = [0, 0];
angle = 0;
targetAngle = 0;
x = 0;
y = 0;
view_enabled = true;
view_set_visible(0, true);
camera_set_view_pos(view_camera[0], -floor(room_width / 2), -floor(room_height / 1.25));