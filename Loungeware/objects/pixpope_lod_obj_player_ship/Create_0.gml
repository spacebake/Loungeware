/// @description Insert description here
// You can write your code in this editor
spawn = new pixpope_timer(30, 30, animcurve_get_channel(pixpope_lod_ac_approach, "cubic"), function(){sfx_play(pixpope_lod_sfx_spawn)}, function(){pixpope_lod_obj_reticle.startGame()});
shrink = new pixpope_timer(10,, animcurve_get_channel(pixpope_lod_ac_generic, "cubicIn"));
escape = new pixpope_timer(30,, animcurve_get_channel(pixpope_lod_ac_generic, "cubicIn"), function(){sfx_play(pixpope_lod_sfx_spawn)});
escapeShrink = new pixpope_timer(10,30, animcurve_get_channel(pixpope_lod_ac_generic, "cubicIn"));
start = -50;
x = start;

victory = false;






