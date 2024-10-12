game=orphillius_pet_game_o
rmw=game.rmw
rmh=game.rmh
pet=game.pet
gain=game.gain

startx=choose(16,rmw-16)
starty=irandom_range(rmh-32,32)
x=startx
y=starty

image_xscale=16
image_yscale=16
image_angle=irandom(360)

throwtime=24	//frames for throw anim to last
dist_inc=point_distance(x,y,pet.x,pet.y)/throwtime
scale_inc=abs(4-image_xscale)/throwtime

anim=noone
anim_phase=0;anim_c=0
end_dir=0

end_anim_dur=10	//length of item anim to run after anim is complete