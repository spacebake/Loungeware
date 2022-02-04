effects = [
[ anti_dungeon_sp_fx1, .5, 4 ],
[ anti_dungeon_sp_fx2, .6, 4 ],
[ anti_dungeon_sp_fx3, .8, 4 ],
[ anti_dungeon_sp_fx4, .8, 6 ],
[ anti_dungeon_sp_fx5, .8, 5 ],

];

fnum = irandom(array_length(effects)-1);

depth = -10;
hitframe = 0;
hitshake = false;

function setup() {
	var f = effects[ fnum ];
	sprite_index = f[0];
	image_speed = f[1];
	image_blend = make_color_hsv(random(255),255,255);
	hitframe = f[2];
	hitshake = false;
}