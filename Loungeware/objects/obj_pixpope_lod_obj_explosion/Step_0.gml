/// @description Insert description here
// You can write your code in this editor
timer++;
image_xscale = lerp(.01, 50, timer / length);
image_yscale =  lerp(5, .01, 
	animcurve_channel_evaluate(animcurve_get_channel(pixpope_lod_ac_generic, "cubic"), timer / length));
if( timer >= length)
	instance_destroy();





