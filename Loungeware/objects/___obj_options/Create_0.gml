___state_setup("normal");

t = 0
xpos = room_width / 2;
ypos = room_height / 2 - 100;
menu_y = ypos + 200;
prompt_ypos = ypos + 100;

confirmed = false;
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

rebinding = false;
listen_for_rebind = false;
listen_for_rebind_prev = false;
rebinds = ["right", "up", "left", "down", "primary", "secondary", "pause"];
rebind_index = 0;
rebind_y = ypos + 200;
rebind_curr_y = rebind_y + 100;
rebind_gap = 20;

function back_to_main(){
	with (instance_create_layer(0, 0, layer, ___obj_main_menu)){
		skip_intro = true;
	}
	___global.menu_cursor_gallery = 0;
	instance_destroy();
}
