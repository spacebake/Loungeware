/// @description
image_xscale += .2;
image_yscale = image_xscale;

life --;
image_alpha = life / 15;
if(life < 0) instance_destroy();
