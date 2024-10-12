if request!=noone and instance_exists(pet){
	request_angle+=request_wiggle_dir*3
	if abs(request_angle)>15{request_wiggle_dir*=-1}
	var xx=pet.x
	var yy=pet.y-60
	draw_sprite_ext(orphillius_pet_bubble_s,0,xx,yy,drawscale,drawscale,0,c_white,1)
	draw_sprite_ext(request,0,xx,yy,drawscale,drawscale,request_angle,c_white,1)
}

draw_set_color(c_white)
draw_set_font(fnt_impendium)
var mx=rmw-128-16
var my=32
for (var menuc=0;menuc<array_length(menu_options);menuc++){
	draw_text_ext_transformed(mx,my,menu_options[menuc],0,420,4,4,0)
	if menuc=menu_current{
		draw_sprite_ext(orphillius_pet_menu_select_s,floor(anim_c),mx-32,my+32,drawscale,drawscale,0,c_white,1)
	}
	my+=32
}

var xx=32
var yy=32
var spw=sprite_get_width(orphillius_pet_score_s)*drawscale/2
for (var c=0;c<success_req;c++){
	if c<successes{var subimg=1}else{var subimg=0}
	draw_sprite_ext(orphillius_pet_score_s,subimg,xx,yy,drawscale/2,drawscale/2,0,c_white,1)
	xx+=spw+4
}