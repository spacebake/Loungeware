//text
var w = sprite_get_width(tfg_swipe_spr_top);
var w_half = w / 2;
var h = sprite_get_width(tfg_swipe_spr_top) / 2;
var h_half = h / 2;

var xoff = 115;
var yoff = 25;
var padx = 20;
var pady = 25;

var xx = room_width / 2 - w_half + xoff + padx;
var yy = room_height / 2 - h_half + yoff + pady;

tfg_draw_set_text(c_white, tfg_swipe_fnt_game, fa_left, fa_top);

draw_text(xx + flipflop * inc, yy, text);


