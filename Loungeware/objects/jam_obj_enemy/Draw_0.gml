/// @desc Draw enemy.
var xpos = floor(x);
var ypos = floor(y);
draw_sprite_ext(jam_spr_shield, 0, xpos, ypos, 0.5, 0.5, -current_time * 0.1, c_white, 1 - entryTimer);
part_system_drawit(partSys);
if (hitTimer > 0.75 && current_time % 150 > 100) {
    gpu_set_blendmode(bm_add);
}
jam_draw_witch(witch, blastTimer > 0.5, jam_spr_enemy_broom, 0, xpos, ypos, -1, 1, c_white, hp <= 0 ? hitTimer : 1, xspeed, yspeed);
gpu_set_blendmode(bm_add);
draw_sprite_ext(jam_spr_shield, 0, xpos, ypos, 0.5, 0.5, current_time * 0.1, c_white, 1 - entryTimer);
gpu_set_blendmode(bm_normal);
var sep = 6;
var hp_width = 7;
var solid_rows = max(0, ceil(hp / hp_width) - 1);
var fluid_cols = hp - solid_rows * hp_width;
for (var i = 0; i < fluid_cols; i += 1) {
    draw_sprite(jam_spr_heart, 0, xpos - (fluid_cols - 1) * sep / 2 + i * sep, ypos - 20);
}
var solid_left = xpos - (hp_width - 1) * sep / 2;
for (var i = 0; i < solid_rows; i += 1) {
    for (var j = 0; j < hp_width; j += 1) {
        draw_sprite(jam_spr_heart, 0, solid_left + j * sep, ypos - 20 - (i + 1) * sep);
    }
}
//draw_sprite(jam_spr_enemy_hitbox, 0, xpos, ypos);
//draw_text(x,y+30,lifeTimer);
//draw_text(x,y+50,exitTimer);