/// @description flight variables

max_force_magnitude = 5;
var _chargeAmount = noah_artillery_obj_player.charge;
initial_force_magnitude = _chargeAmount * max_force_magnitude
start_angle = noah_artillery_obj_player.aim_direction;
image_speed = _chargeAmount;

// split force into components
force_x = lengthdir_x(initial_force_magnitude, start_angle);
force_y = lengthdir_y(initial_force_magnitude, start_angle);

vspeed = force_y;
hspeed = force_x;
gravity = 0.1;

// Create muzzle flash
instance_create_depth(x, y, depth - 1, noah_artillery_obj_flash);

explode = function(){
	instance_create_depth(x, y, depth - 1, noah_artillery_obj_explosion);
	instance_destroy();	
};

// Start alarm that leaves smoke trail
puff_frequency = 5; // every 5 frames
alarm_set(0, puff_frequency);