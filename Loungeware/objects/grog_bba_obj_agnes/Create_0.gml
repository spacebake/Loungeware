/// @description Insert description here
// You can write your code in this editor

bgm_pitch = 1

flyin = true

start_x = -59
start_y = y - 60

tick = 0 
flyin_length = lerp(1.2, .8, (DIFFICULTY - 1) / 4) * room_speed


freeze = 0
dead = false


x = start_x
y = start_y


sfx_id = noone
sfx_vol = 1
in_control = true
on_broom = true

broom = choose(grog_bba_broom, grog_bba_lunar_broom, grog_bba_star_broom)
broom_end = sprite_get_width(broom) - sprite_get_xoffset(broom)


ps = part_system_create()
part_system_depth(ps, depth+1)


