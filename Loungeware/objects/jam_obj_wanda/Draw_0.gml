/// @desc Draw Wanda.
var xpos = floor(x);
var ypos = floor(y);
var img = current_time % 2000 > 1750;
part_system_drawit(partSys);
if (blast) {
    img = 3;
} else if (hitTimer > 0.5 || global.jamHp <= 5 && instance_exists(jam_obj_gameloop)) {
    img = 2;
}
if (hitTimer > 0 && current_time % 150 > 100) {
    gpu_set_blendmode(bm_add);
}
jam_draw_witch(jam_spr_wanda, img, jam_spr_wanda_broom, 0, xpos, ypos, 1, 1, c_white, 1, xspeed, yspeed);
gpu_set_blendmode(bm_normal);
//draw_sprite(jam_spr_wanda_hitbox, 0, x, y);