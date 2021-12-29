___state_setup("normal");

t = 0
xpos = room_width / 2;
ypos = room_height / 2 - 200;
menu_y = ypos + 200;
prompt_ypos = ypos + 50;

confirmed = false;
prev_confirmed = false;
cursor = 0;
title_txt = {
	normal: "OPTIONS",
	controls: "CONTROLS",
};
	
menu = [
	{ 
		text: "CONTROLS",
		prompt: "Press [ANYKEY] to start remapping, or [PAUSE] to go back",
		op: method(self, function() { ___state_change("controls") }), 
	},
	{ 
		text: "ASDFG",
		op: method(self, function() { ___state_change("controls") }), 
	},
];

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}
