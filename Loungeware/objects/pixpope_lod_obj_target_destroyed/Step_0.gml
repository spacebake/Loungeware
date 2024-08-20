/// @description Insert description here
// You can write your code in this editor
part_particles_create(pixpope_lod_obj_reticle.partSystemBehind, x, y, global.pixpope_particle_lod_fire, 1);
part_particles_create(pixpope_lod_obj_reticle.partSystemBehind, x, y, global.pixpope_particle_lod_smoke, 1);
image_blend = c_gray;
image_angle -= .2;
vspeed += .1;
hspeed -= .001;


if(y > room_height + 200) instance_destroy();
