___state_setup("reveal");

sprite_index = ___spr_title_mimpy_jump;
image_speed = 0;
x = 110;
y = 190;
vsp = 0;
hsp = 0;
grav = 0.4;
grav_max = 10;

steps = 0;
wait = 0;

logo_y = ___obj_title_screen.logo_y;
logo_x = VIEW_W/2;
on_logo = true;
logo_platform_y = 0;
logo_x_offset = 0;
logo_scale = 0;

floor_y = VIEW_H - sprite_get_height(___spr_label_template2)

mimpy_shake = 0;
screenshake = 0;

net_x = WINDOW_BASE_SIZE + 50;
net_frame = 0;

engine_sound = noone;

function draw_cover_logo(){
	if (!instance_exists(___obj_title_screen)) return;
	with (___obj_title_screen){
		var _logo_x = WINDOW_BASE_SIZE/2;
		var _logo_y = logo_y;
		var _spr = ___spr_logo_title;
		var _frame = 0;
		var _alpha = 1;
		var _logo_scale = logo_scale - ((0.1 * (((next_beat_prog-1)/4) / 0.25)) * logo_scale_master);
	}
	
	
	draw_sprite_ext(_spr, _frame, _logo_x, _logo_y, _logo_scale, _logo_scale, 0, c_white, _alpha);
}

smoke_parts = [];


function create_smoke_part(){
	if (irandom(5) > 0) return;
	var _data = {
		x : net_x + 38,
		y : floor_y - 43,
		alpha : 1,
		hsp : random_range(1.5, 2.5),
		vsp : random_range(-1, -2) * 0.25,
	}
	_data.hsp_max = _data.hsp;
	array_push(smoke_parts, _data);
}

function move_smoke_part(){
	for (var i = 0; i < array_length(smoke_parts); i++){
		var _data = smoke_parts[i];
		_data.hsp *= 0.92;
		_data.vsp *= 0.99;
		_data.x += _data.hsp;
		_data.y += _data.vsp;
		_data.alpha = _data.hsp / _data.hsp_max;
		
		log(_data.alpha);
		if (_data.alpha <= 0.01){
			array_delete(smoke_parts, i, 1);
			i--;
		}
	}
}

function draw_smoke_part(){
	
	for (var i = 0; i < array_length(smoke_parts); i++){
		var _data = smoke_parts[i];
		if (_data.x > WINDOW_BASE_SIZE + 8 || _data.x < -8) continue;
		var _spr = ___spr_title_smoke_part;
		var _alpha = floor(_data.alpha * 100) / 100;
		var _img = (sprite_get_number(___spr_title_smoke_part) - 0.01) * (1-_alpha);
		draw_sprite_ext(_spr, _img, _data.x, _data.y, 1, 1, 0, c_white, _alpha);
		
	}
}