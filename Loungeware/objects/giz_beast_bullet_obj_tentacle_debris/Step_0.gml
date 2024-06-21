image_alpha -= 0.03;
image_angle += angle_dir * angle_spd;
//image_xscale += 0.01;
//image_yscale = image_xscale;
if ( image_alpha <= 0 ) instance_destroy();