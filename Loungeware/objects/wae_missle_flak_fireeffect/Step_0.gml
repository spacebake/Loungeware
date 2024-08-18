/// @description Insert description here
// You can write your code in this editor

if image_index > image_number -1
{
	instance_destroy(self)
}
image_angle= wae_missle_flak.image_angle
x =   wae_missle_flak.x +   wae_missle_flak.wae_missle_cannondseparation[wae_missle_flak.wae_missle_flak_index]*dcos(image_angle-45+90) + wae_missle_flak.wae_missle_cannondist*dcos(image_angle-45)
y =   wae_missle_flak.y + -1*wae_missle_flak.wae_missle_cannondseparation[wae_missle_flak.wae_missle_flak_index]*dsin(image_angle-45+90) - wae_missle_flak.wae_missle_cannondist*dsin(image_angle-45)



