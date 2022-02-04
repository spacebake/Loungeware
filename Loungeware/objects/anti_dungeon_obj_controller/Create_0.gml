
randomize();

musicid = microgame_music_start(anti_dungeon_music,1,false);
bogos = "";

back_ind = irandom(sprite_get_number(anti_dungeon_sp_back));
textbox_ind = 0;
textbox_open = 0;

desc_draw = "";
battlestage = 0;
dosomething = 90;
dosomething_def = dosomething;
dosomething_between = 50;
penaltytimer = 0;
penalty_time = 35;
hitselect = 1;
optionflip = 1;
damage = irandom_range(34,48); //always 3 hits

//enemy
enemy_introtime = 45;
enemy_intro_y = -55;
enemy_spr = anti_dungeon_sp_enemy;
enemy_ind = irandom(sprite_get_number(anti_dungeon_sp_enemy));
enemyshake = 0;
enemysurf = surface_create(room_width,room_height);


//scrolling numbers
enemyhealth = 100;
enemyhealth_display = enemyhealth;
enemyhealth_draw = [enemyhealth,floor(enemyhealth/10),floor(enemyhealth/100)];

enemyatk = irandom_range(5,70);
enemyatk_draw = [enemyatk,floor(enemyatk/10),floor(enemyatk/100)];

enemymagic = irandom_range(5,50);
enemymagic_draw = [enemymagic,floor(enemymagic/10),floor(enemymagic/100)];



enemynames = [
"Jeff",
"Jeff 2.0",
"Bruiser",
"Breaker",
"Baker",
"Grug",
"Wally",
"Jones",
"Fang",
"Ash",
"Hook",
"Shade",
"Howler",
"Jinx",
"Echo",
"Rogue",
"Ripper",
"Blight",
];

verbs = [
"attacks",
"approaches",
"slides in",
"threatens you",
"invades",
"materializes",
];
attacks = [
["smack","slack"],
//["bint","print"],
["slice","spice"],
["defeat","greet"],
["strike","psych"],
//["charge","barge"],
["fight","delight"],
//["",""],
];
attacksounds = [
//"hit!",
"Crash!",
"Smaaaash!!",
"Pow!",
"Bonk!",
"Bam!",
"Boom!",
];
failsounds = [
"Oops!",
"Uh oh!",
"Whoops!",

];


atk_ind = -1;
atk_last = -1;
atk = ["bruh","moment"];
desc = enemynames[irandom(array_length(enemynames)-1)] + " " + verbs[irandom(array_length(verbs)-1)] + "!";

fx_last = -1;



function drawnum(x,y,num) {
	num = num % 10;
	var spc = 6;
	var t = sprite_get_yoffset(anti_dungeon_sp_numbers) + num*spc;
	draw_sprite_part(anti_dungeon_sp_numbers,0, 0,t, 3,spc, x,y);
}
function drawnum_multi(x,y,arr,dnum) {
	dnum = clamp(dnum,0,999);

	array_set(arr,0, lerp(arr[0],dnum,.1) );
	array_set(arr,1, lerp(arr[1],floor(dnum/10),.1) );
	array_set(arr,2, lerp(arr[2],floor(dnum/100),.1) );
	
	drawnum(x,y,   arr[2] );
	drawnum(x+4,y, arr[1] );
	drawnum(x+8,y, arr[0] );

}