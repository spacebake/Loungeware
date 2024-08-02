/// @description
gpu_set_blendmode(bm_add)
draw_set_color(c_white);
draw_set_alpha(image_alpha);
draw_rectangle(0,0,room_width, room_height, false);
draw_set_alpha(1)
gpu_set_blendmode(bm_normal)
