enum HAND_STATE {
	FREE,
	GRAB,
	
	SIZE
}

image_speed = 0;

x = room_width / 2;

xx = x;
yy = y;

sprite = 0;

hspd = 0;
vspd = 0;

arm_speed = 0;
acceleration = 0.09;

state = HAND_STATE.FREE;
held_item = noone;

grab = function() {
	var _item = instance_place(x, y, sandveech_bg_obj_item);
	_item.grabbed = true;
	held_item = _item;
	
	sprite = 1;
	state = HAND_STATE.GRAB;
}

release = function() {
	held_item.hdir = hspd;
	held_item.vdir = vspd;
	held_item.grabbed = false;
	held_item = noone;
	
	sprite = 0;
	state = HAND_STATE.FREE;	
}