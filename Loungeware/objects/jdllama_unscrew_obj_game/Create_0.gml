randomize();

orig_order = ["left", "down", "right", "up"];

starter = irandom_range(0, array_length(orig_order) - 1);

screw_total = 4 + (4 * DIFFICULTY);

curr = starter;

results = [];

for(var i = 0;i<screw_total;i++) {
	array_push(results, orig_order[curr]);
	curr++;
	if(curr >= array_length(orig_order)) curr = 0;
	
}

_step = function() {
}

//show_debug_message(string(results));