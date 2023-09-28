#macro giz			giz_core_main
#macro giz_init		instance_create_depth(0, 0, 0, giz_core_main, new giz_core())

function giz_core() constructor {
	
	game	= new giz_game();
	hash	= new giz_hash();
	camera	= new giz_camera();
	math	= new giz_math();
		
}
function giz_game() constructor {
	
	time		= 12;
	paused		= false;
	is_won		= false;
	finished	= false;	
	on_finish	= new giz_delegate();
	end_delay	= 1;
	
	static set_win = function(_win){
		is_won = _win;
		if ( _win ) microgame_win();
		else microgame_fail();
	}
	static finish = function(){
		finished = true;
		on_finish.call();
	}
	static time_set = function(_time){
		time = _time;	
		time_reset(time);
	}
	static time_reset = function(){
		microgame_set_timer_max(time);	
	}
	static is_finished = function(){
		return finished;	
	}
	static update = function(){
		if ( !finished ) return;
		if ( end_delay && !--end_delay ) {
			microgame_end_early();
		}
	}
	
}
function giz_delegate() constructor {
	
	list = [];
	static add = function(val) { array_push(list, val); }
	static remove = function(val){
		var _index = array_find_index(list, method({val:val}, function(v){
			return v == val;
		}));
		if ( _index != -1 ) array_delete(list, _index, 1);
	}
	static clear = function(){ list = []; }
	static call = function(arg=undefined){
		array_foreach(list, method({arg:arg}, function(fn){
			fn(arg);
		}));
	}
	
}	
function giz_hash() constructor {
	
	x = variable_get_hash("x");
	y = variable_get_hash("y");
	
	static get = function(struct, hash){ return struct_get_from_hash(struct, hash); };
	static set = function(struct, hash, val){ return struct_set_from_hash(struct, hash, val); };

}
function giz_camera() constructor {
	
	id		= view_camera[0];
	shake	= 0;

	static size = function(_w=undefined, _h=undefined){
		_w ??= camera_get_view_width(id);
		_h ??= camera_get_view_height(id);
		camera_set_view_size(id, _w, _h);
		return { x : _w, y : _h, width : _w, height : _h };
	}
	static rotation = function(_ang=undefined){
		_ang ??= camera_get_view_angle(id);
		
		camera_set_view_angle(id, _ang);
		return _ang;
	}
	static position = function(_x=undefined, _y=undefined){
		_x ??= camera_get_view_x(id);
		_y ??= camera_get_view_y(id);
		
		camera_set_view_pos(id, _x, _y);
		return { x : _x, y : _y };
	}
	static update = function(){
		shake = lerp(shake, 0, 0.1);
		position(giz.math.rand(-shake, shake), giz.math.rand(-shake, shake));
	}
	
	
}
function giz_math() constructor {
	
	// Internal functions
	static __operation = function(n0, n1, operator){
		switch(operator){
			case "+" : return n0 + n1; break;
			case "-" : return n0 - n1; break;
			case "*" : return n0 * n1; break;
			case "/" : return n0 / n1; break;
			case "%" : return n0 % n1; break;
			case "&" : return n0 & n1; break;
			case "|" : return n0 | n1; break;
			case "^" : return n0 ^ n1; break;
			case ">>": return n0 >> n1; break;
			case "<<": return n0 << n1; break;
		}
		return 0;
	}
	static __evaluate = function(v0, v1, opstr){
		if ( !is_struct(v0) && !is_struct(v1) ) return __operation(v0, v1, opstr);
		if ( is_struct(v0) && !is_struct(v1) ) {
			v0.x = __operation(v0.x, v1, opstr);
			v0.y = __operation(v0.y, v1, opstr);
			return v0;
		}
		if ( !is_struct(v0) && is_struct(v1) ) {
			v1.x = __operation(v1.x, v0, opstr);
			v1.y = __operation(v1.y, v0, opstr);
			return v1;
		}
		if ( is_struct(v0) && is_struct(v1) ) {
			return vec2(
				__operation(v0.x, v1.x, opstr),
				__operation(v0.y, v1.y, opstr)
			);
		}	
	}
	
	// Vector functions
	static vec2 = function(_x=undefined, _y=undefined){
		_x ??= 0;
		_y ??= 0;
		
		if ( is_struct(_x) ){
			var _yv = giz.hash.get(_x, giz.hash.y);
			if ( _yv != undefined ) _y = _yv;
		}
		return { x : _x, y : _y };
	}
	
	// Arithmetic functions
	static add = function(v0, v1){ return __evaluate(v0, v1, "+"); }
	static subtract = function(v0, v1){ return __evaluate(v0, v1, "-"); }
	static divide = function(v0, v1){ return __evaluate(v0, v1, "/"); }
	static multiply = function(v0, v1){ return __evaluate(v0, v1, "*"); }
	static modulo = function(v0, v1){ return __evaluate(v0, v1, "%"); }
	
	// Bitwise functions
	static bitand = function(v0, v1){ return __evaluate(v0, v1, "&"); }
	static bitor = function(v0, v1){ return __evaluate(v0, v1, "|"); }
	static bitxor = function(v0, v1){ return __evaluate(v0, v1, "^"); }
	static bitleft = function(v0, v1){ return __evaluate(v0, v1, "<<"); }
	static bitright = function(v0, v1){ return __evaluate(v0, v1, ">>"); }
	
	// Random functions
	static rand = function(v0=100, v1=undefined){
		if ( v1 == undefined ) return random(v0);
		return random_range(v0, v1);
	}
	static irand = function(v0=100, v1=undefined){
		if ( v1 == undefined ) return irandom(v0);
		return irandom_range(v0, v1);
	}
	
}