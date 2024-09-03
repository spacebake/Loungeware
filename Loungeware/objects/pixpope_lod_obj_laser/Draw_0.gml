/// @description Insert description here
// You can write your code in this editor

if(!surface_exists(surf)){	
	surf = surface_create(surface_get_width(application_surface), surface_get_height(application_surface));
}

surface_set_target(surf);
camera_apply(view_camera[0]);
draw_clear_alpha(c_white, 0);
pixpope_array_foreach(myTrail, function(_x){with(_x)draw_self()})
surface_reset_target();

gpu_set_blendmode(bm_add);
draw_surface_stretched(surf, 0, 0, room_width, room_height)
gpu_set_blendmode(bm_normal);

//draw_path(myPath,0,0,true);