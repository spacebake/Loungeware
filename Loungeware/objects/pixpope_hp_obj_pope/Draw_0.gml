/// @description
gpu_set_fog(true, c_white, -16000, 16000);
draw_sprite(sprite_index, image_index, x, y);
gpu_set_fog(false, 0, 0, 0);

draw_self();

