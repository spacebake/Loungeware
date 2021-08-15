randomize();
spr = choose(tfg_swipe_spr_netfloosh,
	tfg_swipe_spr_spacefloosh,
	tfg_swipe_spr_tfgfloosh,
	tfg_swipe_spr_nommfloosh,
	tfg_swipe_spr_katfloosh,
	tfg_swipe_spr_gracefloosh);

pos = 0;
spd = 0;

swiped = false;

range = {
	min: 35,
	max: 43,
}

start_text = "please swipe card";
slow_text = "too slow."
fast_text = "too fast."
succ_text = "accepted."
text = start_text;

draw = function() {
	draw_self();
	
	//pics
	xoff = 225 - 36;
	yoff = 115 - 56;
	xx = x - xoff;
	yy = y - yoff;
	w = 174;
	h = 174;

	draw_sprite_stretched(spr, 0, xx, yy, w, h);	
}

image_speed = 0;

inc = 10;
inc_every = 60;
inc_curr = 0;
flipflop = false;
