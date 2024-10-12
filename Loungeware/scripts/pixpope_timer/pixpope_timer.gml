// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function pixpope_timer(_length, _delay = 0, _curve = undefined, _onStart = undefined, _onDone = undefined) constructor{
	timer = -_delay;
	length = _length;
	curve = _curve;
	done = false;
	onStart = _onStart;
	onDone = _onDone;
	update = function(){
		if(done) return;
		if(timer == 0 && onStart != undefined) onStart();
		timer++;
		if(timer == length){
			done = true;
			if(onDone != undefined)
				onDone();
		}
	}
	
	getPosition = function(){
		if(timer <= 0) return 0;
		if(curve == undefined) return timer / length;	
		return animcurve_channel_evaluate(curve, timer / length)
	}
}