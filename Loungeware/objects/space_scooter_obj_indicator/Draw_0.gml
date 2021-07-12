
var _sx = 0;
var _sy = 0;
var _sv = 1;


if (state == 0){
	scale = -lengthdir_y(1.2, scale_dir)
	scale_dir += 10;
	if (scale_dir > 90 && scale <= 1){
		scale = 1;
		state++;
		wait = 10;
	}
}


if (state == 1){
	if (wait <= 0){
		state++;
		wait = 10;
	}
	wait--;
}
if (state == 2){
	if (wait <= 0){
		wait = 30;
		state++;
	}
	_sx = random_range(-_sv, _sv);
	_sy = random_range(-_sv, _sv);
	wait--;
	
}

if (state == 3){
	if (wait <= 0){
		state++;
		wait = 10;
	}
	wait--;
}

if (state == 4){
	image_alpha = max(0, image_alpha - (1/20));
}



var _x = VIEW_X + x + _sx;
var _y = VIEW_Y + y + _sy;

draw_set_font(fnt_frogtype);
draw_set_color(txt_col);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(image_alpha);

draw_sprite_ext(sapce_scooter_spr_x, frame, _x, _y, scale, scale, 0, c_white, image_alpha);

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);