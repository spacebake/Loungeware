/// @description Insert description here
// You can write your code in this editor


if KEY_LEFT
{
	image_angle += 2
}
if KEY_RIGHT
{
	image_angle -= 2
}

wae_missle_counter += 1
var addx =    wae_missle_cannondseparation[wae_missle_flak_index]*dcos(image_angle-45+90) + wae_missle_cannondist*dcos(image_angle-45)
var addy = -1*wae_missle_cannondseparation[wae_missle_flak_index]*dsin(image_angle-45+90) - wae_missle_cannondist*dsin(image_angle-45)
if wae_missle_counter mod wae_missle_fire_delay == 0 and wae_missle_counter > 70 and not wae_missle_lost and instance_number(wae_missle_missle)
{
	instance_create_depth(x+addx,y+addy,depth+1,wae_missle_flak_bullet)
	instance_create_depth(x+addx,y+addy,depth-1,wae_missle_flak_fireeffect, {image_angle : image_angle})
	wae_missle_flak_index = not wae_missle_flak_index
	image_speed = 2
	if wae_missle_flak_index
	{
		image_index = 1
	}
	else
	{
		image_index = 4
	}
}
else if image_index == 1 or image_index == 4
{
	image_index = 0
	image_speed = 0
}

if wae_missle_counter mod wae_missle_enemy_delay == 0 and not wae_missle_lost and wae_missle_counter < 571 -200
{
	instance_create_layer(x,y,"midground_instances",wae_missle_missle)
}
if wae_missle_counter mod wae_missle_enemy_delay2 == 0 and not wae_missle_lost and wae_missle_counter < 571 -220
{
	instance_create_layer(x,y,"background_instances",wae_missle_backgroundeffect)
}
if wae_missle_lost
{
	sprite_index = wae_missle_flakSpriteSad
	wae_missle_lost_delay += 1
	if wae_missle_lost_delay > 100
	{
		microgame_end_early()
	}
}
if instance_number(wae_missle_missle) == 0 and wae_missle_counter > 571 -200 and not wae_missle_lost
{
	sprite_index = wae_missle_flakSpriteHappy
	wae_missle_lost_delay += 1
	if wae_missle_lost_delay > 50
	{
		microgame_end_early()
	}
}
