visible = ( wait <= 0 );
if ( --wait > 0 ) exit;
image_angle += angle_dir * angle_spd;
direction += angle_difference(270, direction)*grv*.1;
x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);