/// @desc
vis = true;
invis = false;

sprites = {
	eyes_1: { spr_normal: josh_eyes_sEye, spr_reverse: josh_eyes_sEyeReverse, spr_dummy: josh_eyes_sEyeDummy },
	eyes_2: { spr_normal: josh_eyes_sEye2, spr_reverse: josh_eyes_sEyeReverse2, spr_dummy: josh_eyes_sEyeDummy2 },
	eyes_3: { spr_normal: josh_eyes_sEye3, spr_reverse: josh_eyes_sEyeReverse3, spr_dummy: josh_eyes_sEyeDummy3 },
	eyes_4: { spr_normal: josh_eyes_sEye4, spr_reverse: josh_eyes_sEyeReverse4, spr_dummy: josh_eyes_sEyeDummy4 }
};
spr = choose(sprites.eyes_1, sprites.eyes_2, sprites.eyes_3, sprites.eyes_4);
spr_index = spr.spr_normal;
spr_reverse = spr.spr_reverse;
sprite_index = spr_index;
image_speed = 0;
image_index = choose(0, image_number - 1);

alarm[0] = irandom_range(30,120);

speed = choose(1,2);
direction = irandom_range(0,270);

invisibility_timer = irandom_range(10,120);
visibility_timer = irandom_range(20,65);
reset_loop = function()
{
	invisibility_timer = irandom_range(10,120);
	visibility_timer = irandom_range(10,65);
}

x = irandom_range(0, room_width);
y = irandom_range(0, room_height);