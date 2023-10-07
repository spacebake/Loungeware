state	= 0;
trigger	= function(){
	state++;
	state = clamp(state, 0, 3);
	
	var _ind = index;
	var _val = state;
	with ( block_buffer ) data[_ind] = _val;
}