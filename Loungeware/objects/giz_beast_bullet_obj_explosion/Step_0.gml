visible = ( wait <= 0 );
if ( --wait > 0 ) exit;

spd = lerp(spd, 0, 0.1);
image_angle += angle_dir * angle_spd * spd;
scale -= 0.05;

if ( scale < 0 ) instance_destroy();
image_xscale = scale;
image_yscale = scale;

x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);