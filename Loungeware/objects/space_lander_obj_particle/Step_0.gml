/// @description 
//# ALLOW banned-functions
prog = ___smooth_move(prog, 1, 0.0001, 20);
//# WARN banned-functions
image_index = starting_frame + ((image_number - starting_frame) * (prog));
x = xstart + lengthdir_x(range*prog, direction);
y = ystart + lengthdir_y(range*prog, direction);

image_alpha = 1 - ((max(0.5, prog)-0.5)*2)
if (prog >= 1){
	instance_destroy();
}
