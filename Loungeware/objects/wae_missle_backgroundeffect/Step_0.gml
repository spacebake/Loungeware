/// @description Insert description here
// You can write your code in this editor


y -= wae_missle_yspd
x += wae_missle_yspd
part_type_direction(wae_missle_mytrail,image_angle+90,image_angle+90,0,0)
var rdx = random_range(-3,3)
part_particles_create(wae_missle_flak.wae_missle_background_partsystem,x+rdx,y,wae_missle_mytrail,1)

wae_missle_yspd = min (3, wae_missle_yspd + 0.05)