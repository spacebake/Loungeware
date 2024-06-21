if ( freeze ) exit;
x = giz_beast_bullet_obj_boss.x + offset_x;
y = giz_beast_bullet_obj_boss.y + offset_y;
if ( xscale < 1 ) xscale += 0.05;
else {
	xscale = 1;
	if ( grow > 0 && subsegment == undefined ) {
		active = true;
		subsegment = instance_create_layer(
		x + lengthdir_x(sprite_get_width(sprite_index), direction),
		y + lengthdir_y(sprite_get_width(sprite_index), direction),
		layer, giz_beast_bullet_obj_tentacle, {
			parent		: id,
			grow		: grow-1,
			grow_max	: grow_max,
			grow_dir	: grow_dir,
			can_fall	: can_fall,
			direction	: direction + grow_dir,
			image_yscale: image_yscale - (1/grow_max),
			image_blend : image_blend
		});
	}
	
	if ( parent != undefined ) {
		if ( !instance_exists(parent) ) can_fall = true;
		else if ( parent.can_fall ) can_fall = true;		
	}
}

if ( can_fall ){
	active = false;
	fall++;
	if ( fall > 0 ){
		fall *= 1.1;
		y += fall;
	}
	image_alpha -= 0.01;
	image_alpha = clamp(image_alpha, -1, .8);
	if ( image_alpha < 0 ) instance_destroy();
}

image_angle = direction;
wait--;