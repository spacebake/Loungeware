/// @description Insert description here
// You can write your code in this editor
wae_missle_flak_rotspeed = 5
wae_missle_arrowkeys.image_alpha = wae_missle_keys_alpha


if wae_missle_always_shoot
{
	wae_missle_flak_rotspeed = 2.5
}
else
{
	if (KEY_PRIMARY or KEY_SECONDARY)
	{
		wae_missle_flak_rotspeed = 2.5
		wae_missle_keys_pressed = true
	}
}

if KEY_LEFT
{
	image_angle += wae_missle_flak_rotspeed
	wae_missle_keys_pressed = true
}
if KEY_RIGHT
{
	image_angle -= wae_missle_flak_rotspeed
	wae_missle_keys_pressed = true
}
if wae_missle_keys_pressed and wae_missle_keys_alpha > 0
{
	wae_missle_keys_alpha -= 0.01
}

wae_missle_counter += 1
var addx =    wae_missle_cannondseparation[wae_missle_flak_index]*dcos(image_angle-45+90) + wae_missle_cannondist*dcos(image_angle-45)
var addy = -1*wae_missle_cannondseparation[wae_missle_flak_index]*dsin(image_angle-45+90) - wae_missle_cannondist*dsin(image_angle-45)
//if wae_missle_counter mod wae_missle_fire_delay == 0 and wae_missle_counter > 70 and not wae_missle_lost and instance_number(wae_missle_missle)
if wae_missle_counter mod wae_missle_fire_delay == 0 and  not wae_missle_lost and (KEY_PRIMARY or KEY_SECONDARY or wae_missle_always_shoot) and not (instance_number(wae_missle_missle) == 0 and wae_missle_counter > 571 -200) and (wae_missle_counter > 70 or not wae_missle_always_shoot)

{
	sprite_index = wae_missle_flakSprite
	var _snd_id = sfx_play(wae_snd_missle_shoot, random_range(0.6,0.8), 0);
	audio_sound_pitch(_snd_id, random_range(0.8,1.2));
	
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
	if not wae_missle_won
	{
		microgame_music_stop()
		sfx_play(wae_snd_missle_defense_victory)
	}
	wae_missle_won = true
	sprite_index = wae_missle_flakSpriteHappy
	wae_missle_lost_delay += 1
	if wae_missle_lost_delay > 60
	{
		microgame_end_early()
	}
}
