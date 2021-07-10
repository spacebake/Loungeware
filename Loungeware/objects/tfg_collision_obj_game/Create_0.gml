/*
$ = orange
% = green
^ = red
# = blue
*/

randomize();

brokens = [
// + vsp
@"$if$ ($place_meeting$(%x% + #vsp#, %y%, ^oWall^)) {
    $while$ (!$place_meeting$(%x% + $sign$(#hsp#), %y%, ^oWall^)) {
        %x% += $sign$(#hsp#);
    }
    #hsp# = ^0^;
}
%x% += #hsp#;",
//nothing in sign
@"$if$ ($place_meeting$(%x% + #hsp#, %y%, ^oWall^)) {
    $while$ (!$place_meeting$(%x% + $sign$(#hsp#), %y%, ^oWall^)) {
        %x% += $sign$();
    }
    #hsp# = ^0^;
}
%x% += #hsp#;",
//no + hsp
@"$if$ ($place_meeting$(%x%, %y%, ^oWall^)) {
    $while$ (!$place_meeting$(%x% + $sign$(#hsp#), %y%, ^oWall^)) {
        %x% += $sign$(#hsp#);
    }
    #hsp# = ^0^;
}
%x% += #hsp#;",
@"$if$ ($place_meeting$(%x% + #hsp#, %y%, ^oWall^)) {
    $while$ (!$place_meeting$(%x% + $sign$(#hsp#), %y%, ^oWall^)) {
        %x% += $sign$(#hsp#);
    }
    #hsp# = ^0^;
}
%x% += #vsp#;", //error
//@"$if$ ($place_meeting$(%x% + #hsp#, %y%, ^oWall^)) {
//    $while$ (!$place_meeting$(%x% + $sign$(#hsp#), %y%, ^oWall^)) {
//        %x% += $sign$(#hsp#);
//    }
//    #hsp# = ^0^;
//}
//%x% += #hsp#;",
]

correct_code = [ [ "$","i","f","$"," ","(","$","p","l","a","c","e","_","m","e","e","t","i","n","g","$","(","%","x","%"," ","+"," ","#","h","s","p","#",","," ","%","y","%",","," ","^","o","W","a","l","l","^",")",")"," ","{" ],[ " "," "," "," ","$","w","h","i","l","e","$"," ","(","!","$","p","l","a","c","e","_","m","e","e","t","i","n","g","$","(","%","x","%"," ","+"," ","$","s","i","g","n","$","(","#","h","s","p","#",")",","," ","%","y","%",","," ","^","o","W","a","l","l","^",")",")"," ","{" ],[ " "," "," "," "," "," "," "," ","%","x","%"," ","+","="," ","$","s","i","g","n","$","(","#","h","s","p","#",")",";" ],[ " "," "," "," ","}" ],[ " "," "," "," ","#","h","s","p","#"," ","="," ","^","0","^",";" ],[ "}" ],[ "%","x","%"," ","+","="," ","#","h","s","p","#",";" ] ];

for (var i = 0; i < array_length(brokens); i++) {
	var yy = 0;
	var j = 0;
	var broken = brokens[i];
	var temp = [];
	
	for (var __j = 1; __j < string_length(broken) + 1; { __j++; j++ }) {
		var char = string_char_at(broken, __j);
		
		if (char == "\r") {
			yy++;
			j = -1;
			continue;
		}
		temp[yy][j] = char;
	}
	
	brokens[i] = temp;
	for (var j = 0; j < array_length(brokens[i]); j++) {
		brokens[i][j] = array_filter(brokens[i][j], function(_char) { return _char != "\n" })	
	}
}

broken_code = brokens[irandom(array_length(brokens) - 1)];

//draw_set_text(c_white, tfg_collision_fnt_jetbrains, fa_left, fa_top);
//line_cols = function(_y) {
//	if (_y > array_length(broken_code) - 1) 
//		return array_length(broken_code[array_length(broken_code) - 1]);
//	if (_y < 0)
//		return array_length(broken_code[0]);
//	return array_length(broken_code[_y]);
//}
rows = array_length(broken_code);

cursor = {
	//x: 0,
	y: 0,
	//w: 2,
	//flash_delay: 30,
	//t: 0,
	//drawing: true,
	buffer_time: 20,
	spd_when_held: 2, //1 unit every 2 frames
	spd_when_held_t: 0,
}

//any_dir_key = function() {
//	return /*KEY_RIGHT || KEY_LEFT || */KEY_UP || KEY_DOWN;
//}

time_held = {
	/*left: 0, right: 0, */up: 0, down: 0,	
}
update_time_held = function() {
	struct_foreach(time_held, function(_item) {
		time_held[$ _item]++;
	});
	
	//if (!KEY_RIGHT)	time_held.right = 0;
	//if (!KEY_LEFT) time_held.left = 0;
	if (!KEY_UP) time_held.up = 0;
	if (!KEY_DOWN) time_held.down = 0;
}

//function EditMenuOption(_name, _callback) constructor {
//	callback = _callback;
//	name = _name;
//}
//edit_menu = [
//	new EditMenuOption("Backspace", function() {
//		if (cursor.x <= 0) exit;
//		array_delete(broken_code[cursor.y], --cursor.x, 1);
//	}),
//	new EditMenuOption("+ hsp", function() {
//		array_foreach(array_reverse(["+", " ", "h", "s", "p"]), function(_char) {
//			array_insert(broken_code[cursor.y], cursor.x, _char);
//		});
//	}),
//];
//edit_menu_w = 0;
//edit_menu_x_pad = 20;
//edit_menu_y_pad = 10;
//draw_set_font(tfg_collision_fnt_frogtype);
//for (var i = 0; i < array_length(edit_menu); i++) { 
//	edit_menu_w += string_width(edit_menu[i].name) + edit_menu_x_pad * 2; 
//}
//edit_menu_h = string_height("M") + edit_menu_y_pad * 2;
//is_edit_menu_draw = false;
//edit_menu_select = 0;

//toggle_edit_menu = function() {
//	is_edit_menu_draw = !is_edit_menu_draw;
//	edit_menu_select = 0;
//}

check_win = function() {
	for (var i = 0; i < array_length(broken_code); i++) {
		if (!array_equals(broken_code[i], correct_code[i]) && cursor.y == i) {
			return true;
		}
	}
	
	return false;
}
get_line = function() {
	for (var i = 0; i < array_length(broken_code); i++) {
		if (!array_equals(broken_code[i], correct_code[i])) {
			return i;
		}
	}
}
win = undefined;

///@func draw_code(code, w, h, ?yy);
draw_code = function(_code, _w, _h, _yy) {
	if (is_undefined(_yy)) _yy = 0;
	draw_set_colour(c_white);
	
	var xx = 0;
	
	for (var i = 0; i < array_length(_code); { i++; _yy++; } ) {
		var line = _code[i];

		for (var k = 0, xx = 0; k < array_length(line); { k++; xx++; } ) {
			var char = line[k];
			if (array_count(colour_chars, char) > 0) {
				draw_set_colour(switch_colour(char));
				xx--;
				continue;
			}
			draw_text(_w * xx, _yy * _h, char);
		}
	}
}

switch_colour = function(_char) {
	if (draw_get_colour() != c_white)
		return c_white;
	
	switch (_char) {
		case "$":
			return 0x6BADEF;
		case "%":
			return 0x55D554;
		case "^":
			return 0x8080FF;
		case "#":
			return 0xFFB1B2;
	}
}
colour_chars = ["$", "%", "^", "#"];

created_bug = false;


