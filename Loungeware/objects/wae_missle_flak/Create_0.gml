/// @description Insert description here
// You can write your code in this editor

sprite_index = wae_missle_flakSpriteNeutral
wae_missle_fire_delay = 8 - floor(DIFFICULTY/2)
wae_missle_enemy_delay = 30 - DIFFICULTY*5
wae_missle_enemy_delay2 = floor(wae_missle_enemy_delay/2)
wae_missle_cannondist = -10
wae_missle_cannondseparation = [3,-2]
wae_missle_flak_index = 0
wae_missle_counter= 0
wae_missle_keys_alpha = 1
wae_missle_won = false
wae_missle_keys_pressed = false
image_speed = 0
wae_missle_flak_imagecounter = 0
wae_missle_flak_fired = false

wae_missle_partsystem = part_system_create()
wae_missle_midground_partsystem = part_system_create_layer("midground_particles",false)
wae_missle_midground_partsystem2 = part_system_create_layer("midground_particles",false)
wae_missle_background_partsystem = part_system_create_layer("background_particles",false)

wae_missle_lost = false
wae_missle_lost_delay = 0
layer_background_speed(layer_background_get_id(layer_get_id("Backgrounds3")), 0 )
layer_background_speed(layer_background_get_id(layer_get_id("Backgrounds4")), 0 )


wae_missle_always_shoot = irandom(1)
if wae_missle_always_shoot
{
	wae_missle_arrowkeys.sprite_index = wae_hog_arrowkeys_sprite
}



