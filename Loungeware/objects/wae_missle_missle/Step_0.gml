/// @description Insert description here
// You can write your code in this editor


y += 1
wae_missle_age += 1
image_xscale = 0.5 + wae_missle_age*0.01*0.4
image_yscale =  0.5 + wae_missle_age*0.01*0.4
var rdx = random_range(-3,3)
if instance_place(x,y,wae_missle_flak_explosiondamage)
{
	part_particles_create(wae_missle_flak.wae_missle_midground_partsystem,x+rdx,y,wae_missle_mydebris,3)
	instance_destroy(self)
	
}

part_type_direction(wae_missle_mytrail,image_angle+90,image_angle+90,0,0)
part_particles_create(wae_missle_flak.wae_missle_midground_partsystem,x+rdx,y,wae_missle_mytrail,1)
if y > room_height and not wae_missle_flak.wae_missle_lost
{
	microgame_fail()
	
	wae_missle_flak.wae_missle_lost = true
	layer_background_speed(layer_background_get_id(layer_get_id("Backgrounds3")), 5 )
	layer_background_speed(layer_background_get_id(layer_get_id("Backgrounds4")), 6 )
}
if wae_missle_flak.wae_missle_lost_delay > 10
{
	instance_destroy(self)
}