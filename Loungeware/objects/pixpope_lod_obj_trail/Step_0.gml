/// @description Insert description here
// You can write your code in this editor
timer++;

var _sat = 255//timer < 5 ? 0 : lerp(0, 128, (timer-5)/10);
var _hue = lerp(0, 255, (timer)/life);

image_blend = make_color_hsv(_hue, _sat, 255);

if(random(1) < .1)
	part_particles_create(pixpope_lod_obj_reticle.partSystem, x, y, global.pixpope_particle_lod_laser_bits, 1);

image_xscale = 1 - (timer / life);
image_yscale = image_xscale;
if(timer >= life) instance_destroy();



