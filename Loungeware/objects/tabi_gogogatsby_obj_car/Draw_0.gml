//set up animation varibles
var _anim_x = 0;
var _anim_y = 0;
var _anim_x_scale = 0;
var _rot = 0;

_anim_y = random_range(-2,2);

//ease to the y location
if(draw_y_position != y){
	draw_y_position = lerp(draw_y_position,y,0.5);
	
	//if close enough to y
	if(abs(draw_y_position - y) <= 0.01){
		draw_y_position = y;
	}
}

//get values from the anmation curve
var _channel = animcurve_get_channel(tabi_gogogatsby_acurve_gatsby_scale, "curve1");
var _channel_two = animcurve_get_channel(tabi_gogogatsby_acurve_gatsby_scale, "curve2");
var _val = current_time/1000;

//keep those values between 0 and 1
if(_val > 1){
	_val = abs(_val - round(current_time/1000));
}

_anim_x_scale = animcurve_channel_evaluate(_channel, _val);
_rot = animcurve_channel_evaluate(_channel_two, _val)*5;

//draw the sprite
draw_sprite_ext(sprite_index,
image_index,
x+_anim_x,
draw_y_position+_anim_y,
image_xscale+_anim_x_scale,
image_yscale,
image_angle+_rot,
image_blend,
image_alpha
);
