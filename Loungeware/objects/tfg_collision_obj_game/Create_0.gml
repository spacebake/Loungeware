brokens = [
["i","f"," ","(","p","l","a","c","e","_","m","e","e","t","i","n","g","(","x"," ","+"," ","h","s","p",","," ","y",","," ","o","W","a","l","l",")",")"," ","{",
"NEWLINE"," "," "," "," ","w","h","i","l","e"," ","(","!","p","l","a","c","e","_","m","e","e","t","i","n","g","(","x"," ","+"," ","s","i","g","n","(","h","s","p",")",","," ","y",","," ","o","W","a","l","l",")",")"," ","{",
"NEWLINE"," "," "," "," "," "," "," "," ","x"," ","+","="," ","s","i","g","n","(","h","s","p",")",";",
"NEWLINE"," "," "," "," ","}",
"NEWLINE"," "," "," "," ","h","s","p"," ","="," ","0",";",
"NEWLINE","}",
"NEWLINE","x"," ","+","="," ","h","s","p",";",
"NEWLINE",
"NEWLINE","i","f"," ","(","p","l","a","c","e","_","m","e","e","t","i","n","g","(","x",","," ","y"," ","+"," ","v","s","p",","," ","o","W","a","l","l",")",")"," ","{",
"NEWLINE"," "," "," "," ","w","h","i","l","e"," ","(","!","p","l","a","c","e","_","m","e","e","t","i","n","g","(","x",","," ","y"," ","+"," ","s","i","g","n","(","v","s","p",")",","," ","y",","," ","o","W","a","l","l",")",")"," ","{",
"NEWLINE"," "," "," "," "," "," "," "," ","y"," ","+","="," ","s","i","g","n","(","v","s","p",")",";",
"NEWLINE"," "," "," "," ","}",
"NEWLINE"," "," "," "," ","v","s","p"," ","="," ","0",";",
"NEWLINE","}",
"NEWLINE","y"," ","+","="," ","v","s","p",";",],
]
draw_set_text(c_white, tfg_collision_fnt_jetbrains, fa_left, fa_top);
cols = room_width div string_width("M");
rows = room_height div string_height("M");

log(room_width, cols, string_width("M"));

cursor = {
	x: 0,
	y: 0,
	w: 2,
	flash_delay: 30,
	t: 0,
	drawing: true,
	buffer_time: 20,
	spd_when_held: 2, //1 unit every 2 frames
	spd_when_held_t: 0,
}

any_dir_key = function() {
	return KEY_RIGHT || KEY_LEFT || KEY_UP || KEY_DOWN;
}

time_held = {
	left: 0, right: 0, up: 0, down: 0,	
}
update_time_held = function() {
	struct_foreach(time_held, function(_item) {
		time_held[$ _item]++;
	});
	
	if (!KEY_RIGHT)	time_held.right = 0;
	if (!KEY_LEFT) time_held.left = 0;
	if (!KEY_UP) time_held.up = 0;
	if (!KEY_DOWN) time_held.down = 0;
}
