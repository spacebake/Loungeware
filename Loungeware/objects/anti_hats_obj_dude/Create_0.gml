/// @description setup


hatspace = 30; //start somewhere random
x = hatspace+irandom(6)*hatspace;
y = room_height-40;

image_xscale = 2;
image_yscale = 2;
image_speed = 0;

targ = x;
won = 0; //-1, 1
timer = 0;
hattime = 15;
spd = 4;
flip = 1;
loserhat = -1;


//create hats
for(var i=hatspace; i<room_width; i+=hatspace;) {
	instance_create_depth(i,6,0,anti_hats_obj_hat);
}

var num = instance_number(anti_hats_obj_hat)-1;
with instance_find(anti_hats_obj_hat,irandom(num)) {
	image_index = 0;	
}


//confetti
ps = part_system_create();
confetti = part_type_create();
var p = confetti;
part_type_shape(p,pt_shape_square);
part_type_size(p,1.3,3.5,0,0);
part_type_gravity(p,.1,300);
part_type_direction(p,230,320,0,0);
part_type_sprite(p,anti_hats_sp_confetti,false,false,true);