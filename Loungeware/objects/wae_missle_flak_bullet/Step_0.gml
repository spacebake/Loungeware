/// @description Insert description here
// You can write your code in this editor
wae_missle_age += 1
wae_missle_mindist = 99999
image_xscale = 0.5 - wae_missle_age*0.01*0.5
image_yscale =  0.5 - wae_missle_age*0.01*0.5
for (var i = 0; i < instance_number(wae_missle_missle); i++)
{
	var mi = instance_find(wae_missle_missle,i)
	var dist = point_distance(x,y,mi.x,mi.y)
	if dist < wae_missle_arming_dist and not wae_missle_armed
	{
		wae_missle_prevmindist = dist
		wae_missle_armed = true
	}
	if dist < wae_missle_mindist
	{
		wae_missle_mindist = dist
	}
}
if wae_missle_armed and wae_missle_prevmindist > wae_missle_mindist
{
	instance_create_depth(x,y,depth,wae_missle_flak_explosion)
	instance_create_depth(x,y,depth,wae_missle_flak_explosiondamage)
	instance_destroy(self)
}

if wae_missle_armed
{
	wae_missle_prevmindist = wae_missle_mindist
}
part_type_direction(wae_missle_mytrail,image_angle,image_angle,0,0)
part_particles_create(wae_missle_flak.wae_missle_partsystem,x,y,wae_missle_mytrail,1)

if y < 0
{
	instance_destroy(self)
}