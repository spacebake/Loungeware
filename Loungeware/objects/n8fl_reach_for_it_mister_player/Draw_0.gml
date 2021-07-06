var t = (TIME_MAX - TIME_REMAINING) / TIME_MAX;

var xx = par_scroll * 0.6;
x = start_x + xx - 50;
draw_self();

if(t >= draw_time){
	draw_sprite_ext(n8fl_reach_for_it_mister_gun_spr, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1);	
}
