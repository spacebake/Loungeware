timer = max(0, timer-1);
prog = 1-(timer/timer_max)
image_index = (image_number*1) * prog;
image_alpha = (1-prog);
x += hsp;
y += vsp;
hsp = hsp * 0.95;
if (x < VIEW_X - 20) instance_destroy();
