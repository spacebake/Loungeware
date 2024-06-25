/// @description Insert description here
// You can write your code in this editor
wae_hog_cpx = room_width/2
wae_hog_cpy = room_height/2

if instance_exists(wae_hog_exit)
{
	wae_hog_ei = instance_find(wae_hog_exit,0)
	var add =  sqrt(instance_number(wae_hog_angry_farmer_anim))
	var addx = add*random_range(-15,15)
	var addy = add*random_range(-15,15)
	x = addx + wae_hog_cpx + (1.5 +add/4)*(wae_hog_cpx - wae_hog_ei.x)
	y = addy + wae_hog_cpy + (1.5 +add/4)*(wae_hog_cpy - wae_hog_ei.y)
}
//x= wae_hog_cpx
//y = wae_hog_cpy
wae_hog_farmer_dir = point_direction(x,y,wae_hog_ei.x + addx,wae_hog_ei.y + addy)
wae_hog_farmer_speed = random_range(1,2)
var xsclsng = 1
if dcos(wae_hog_farmer_dir) < 0
{
	xsclsng = -1
}
image_yscale = random_range(0.8,1.3)
image_xscale = xsclsng*random_range(0.8,1.3)
image_speed = random_range(0.5,1.5)
image_index = irandom_range(0,image_number-1)
