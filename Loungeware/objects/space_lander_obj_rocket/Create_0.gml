land_speed_max = 1;
state = "pause";
state_goto = state;
state_begin = true;
pause_timer = 20;
substate = 0;
thrust_sound_id = noone;

flame_timer_max = 4;
flame_timer = flame_timer_max;
flame_img = 0;
thrusting = false;
ship_shake = 0;
ship_shake_val = 0.5;
ship_index = 0;
landed = false;
view_shake = 0;
view_shake_val = 2;
lid_dir = 0;
lid_speed = 15;
lid_frame = 3;
lid_x_mod = 0;
alien_y_mod = 15;
alien_talked = false;

vsp = 0;
grav = 0.04 + (0.12 * ((DIFFICULTY-1)/5));
grav_max = 5;
floor_y = 132;
oy = y;

state_change = function(_state_goto){
	state_goto = _state_goto;
}

state_handle_changes = function(){
	state_begin = false;
	if (state_goto != state){
		state = state_goto;
		state_begin = true;
	}
}

create_smoke_part = function(_count){
	repeat(_count){
		instance_create_layer(
			irandom_range(bbox_left, bbox_right),
			irandom_range(bbox_top, bbox_bottom),
			layer,
			space_lander_obj_particle
		);
	}
}