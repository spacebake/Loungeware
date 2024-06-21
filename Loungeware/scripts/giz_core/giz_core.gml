#macro giz			giz_core_main
#macro giz_init		instance_create_depth(0, 0, 0, giz_core_main, new giz_core())

function giz_core() constructor {
	
	gpu_default	= gpu_get_state();
	
	update		= new giz_delegate();
	draw		= new giz_delegate();
	cleanup		= new giz_delegate();
	
	game		= new giz_game();
	hash		= new giz_hash();
	camera		= new giz_camera();
	math		= new giz_math();
	d3d			= new giz_d3d();
	
	update.add(game.update);
	update.add(camera.update);
	
	cleanup.add(d3d.cleanup);
	cleanup.add(function(){ 
		gpu_set_state(gpu_default);
		ds_map_destroy(gpu_default);
	});
					
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
	update = function(){
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
		for ( var i=0; i<array_length(list); i++ ){
			var fn = list[i];
			fn(arg);
		}
	}
	
}	
function giz_hash() constructor {
	
	x = variable_get_hash("x");
	y = variable_get_hash("y");
	z = variable_get_hash("z");
	
	static get = function(struct, hash){ return struct_get_from_hash(struct, hash); };
	static set = function(struct, hash, val){ return struct_set_from_hash(struct, hash, val); };

}
function giz_camera() constructor {
	
	id		= view_camera[0];
	shake	= 0;
	view	= camera_get_view_mat(id);
	proj	= camera_get_proj_mat(id);

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
	static reset = function(){
		giz.camera = self;
		camera_set_view_mat(id, view);
		camera_set_proj_mat(id, proj);
	}
	update = function(){
		shake = lerp(shake, 0, 0.1);
		position(giz.math.rand(-shake, shake), giz.math.rand(-shake, shake));
	}
}
function giz_math() constructor {
	
	default_mat = matrix_build_identity();
	
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
			
			var _z = giz.hash.get(v0, giz.hash.z);
			if ( _z != undefined ) v0.z = __operation(v0.z, v1, opstr);
			return v0;
		}
		if ( !is_struct(v0) && is_struct(v1) ) {
			v1.x = __operation(v1.x, v0, opstr);
			v1.y = __operation(v1.y, v0, opstr);
			
			var _z = giz.hash.get(v1, giz.hash.z);
			if ( _z != undefined ) v1.z = __operation(v1.z, v0, opstr);
			return v1;
		}
		if ( is_struct(v0) && is_struct(v1) ) {
			var z0 = giz.hash.get(v0, giz.hash.z);
			var z1 = giz.hash.get(v1, giz.hash.z);
			if ( z0 == undefined && z1 != undefined ) return undefined;
			if ( z1 == undefined && z0 != undefined ) return undefined;
			return ( z0 != undefined && z1 != undefined ? 
			vec3(
				__operation(v0.x, v1.x, opstr),
				__operation(v0.y, v1.y, opstr),
				__operation(v0.z, v1.z, opstr)
			)	:
			vec2(
				__operation(v0.x, v1.x, opstr),
				__operation(v0.y, v1.y, opstr)
			));
		}	
	}
	
	// Vector functions
	static vec2 = function(_x=undefined, _y=undefined){
		_x ??= 0;
		_y ??= _x;
				
		if ( is_struct(_x) ){
			var _yv = giz.hash.get(_x, giz.hash.y);
			if ( _yv != undefined ) _y = _yv;
			_x = _x.x;
		}
		return { 
			x	: _x, 
			y	: _y,
			log : function(){ 
				show_debug_message([x, y]); 
				return self; 
			}
		};
	}
	static vec3 = function(_x=undefined, _y=undefined, _z=undefined){
		
		_z ??= _x;
		var _vec = vec2(_x, _y);
		if ( is_struct(_x) ) {
			var _zv = giz.hash.get(_x, giz.hash.z);
			if ( _zv != undefined ) _z = _zv;
			else if ( _y != undefined ) _z = _y;
		}
		
		return { 
			x	: _vec.x, 
			y	: _vec.y, 
			z	: _z, 
			log : function(){ 
				show_debug_message([x, y, z]); 
				return self; 
			}
		};
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
	
	// Matrix functions
	static matrix = function(v0=undefined, v1=undefined, v2=undefined){
		v0 ??= vec3(0);
		v1 ??= vec3(0);
		v2 ??= vec3(1);
		return matrix_build(v0.x, v0.y, v0.z, v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
	}
	static matrix_reset = function(){
		matrix_set(matrix_world, default_mat);	
	}
}

function giz_d3d() constructor {
	
	default_cam		= undefined;
	render			= new giz_delegate();
	primitive		= new giz_d3d_primitives();
	shader			= new giz_d3d_shader();
	environment		= new giz_d3d_environment();
	collection		= [ primitive ];
	sprites			= {};
	render_surf		= -1;
	enabled			= false;
	
	static load_sprite = function(fileid){
		var _load = sprite_add(fileid, 0, 0, 0, 0, 0);
		var sprite_data = {
			index	: _load,
			sprite	: ( os_browser == browser_not_a_browser ? _load : undefined ),
			sample	: [],
			on_load : function(){
				sprite = index;
				
				var i = 0;
				repeat(array_length(sample)){
					var samp = sample[i++];
					samp.sprite = sprite;
					samp.reload();
				}
				sample = [];
			},
			cleanup	: function(){
				if ( sprite_exists(sprite) ) sprite_delete(sprite);
				struct_remove(giz.d3d.sprites, index);
			}
		};
		sprites[$ _load] = sprite_data;
		cache(sprites[$ _load]);
		return sprite_data;
	}
	static material = function(t=undefined, n=undefined, a=undefined, r=undefined, m=undefined, e=undefined){
		return new giz_d3d_material()
			.set_sampler("texture", t)
			.set_sampler("normal", n)
			.set_sampler("ambient", a)
			.set_sampler("roughness", r)
			.set_sampler("metallic", m)
			.set_sampler("emission", e);
	}
	static model = function(mesh=undefined, mat=undefined){
		return new giz_d3d_model(mesh, mat);	
	}
	static enable = function(camera_struct={}){
		enabled	= true;
		default_cam = giz.camera;
		giz.update.remove(giz.camera.update);
		giz.camera = new giz_d3d_camera(camera_struct);
		giz.update.add(giz.camera.update);
		giz.draw.add(render_scene);	
		
		primitive.enable();
		environment.enable();
			
		gpu_set_ztestenable(true);
		gpu_set_zwriteenable(true);
		gpu_set_alphatestenable(true);
		gpu_set_alphatestref(.01);
		layer_force_draw_depth(true, 0);
		
		render_surf = surface_create(room_width, room_height);
	}	
	static prepare_render = function(){
		if ( !enabled ) return;
		if ( !surface_exists(render_surf) ) render_surf = surface_create(room_width, room_height);
		surface_set_target(render_surf);
			draw_clear_alpha(0, 0);
			camera_apply(giz.camera.id);
			
				render.call();
				
		surface_reset_target();
		giz.math.matrix_reset();
		shader_reset();
	}
	static cache = function(class){
		array_push(collection, class);
	}
	cleanup = function(){
		if ( default_cam == undefined ) return;
		if ( surface_exists(render_surf) ) surface_free(render_surf);
		
		giz.update.remove(giz.camera.update);
		giz.camera = default_cam;
		giz.update.add(giz.camera.update);
		giz.draw.remove(render_scene);
		
		layer_force_draw_depth(false, 0);
		array_foreach(collection, function(class){
			class.cleanup();
		});
		show_debug_message("giz.d3d :: Project Cleaned!");
	}
	render_scene = function(){
		if ( !enabled ) return;
		prepare_render();
		draw_surface(render_surf, 0, 0);	
	}
	
}
function giz_d3d_model(mesh_id=undefined, material_id=undefined) constructor {
	
	mesh_id		??= giz.d3d.primitive.sphere;
	material_id ??= giz.d3d.material();
	
	mesh		= mesh_id;
	material	= material_id;
	position	= giz.math.vec3(0);
	rotation	= giz.math.vec3(0);
	scale		= giz.math.vec3(1);
	
	cleanup = function(){
		giz.d3d.render.remove(draw);	
	}
	draw = function(){
		material.apply();
		mesh.submit(giz.math.matrix(position, rotation, scale), material.texture.texture);
	}
	giz.d3d.render.add(draw);
	
}
function giz_d3d_camera(camera_struct) constructor {
	
	id				= camera_create();
	default_camera	= giz.camera;
	
	distance		= 128;
	position		= giz.math.vec3(0);
	rotation		= giz.math.vec3(0);
	target			= giz.math.vec3(0);
	up				= giz.math.vec3(0, 0, 1);
	
	fov				= 60;
	aspect			= room_width/room_height;
	near			= 1;
	far				= 2048;
	
	first_person	= true;
	
	struct_foreach(camera_struct, function(key, val){
		self[$ key] = val;
	});
	
	view = undefined;
	proj = undefined;

	static reset = function(){
		camera_set_view_mat(id, default_camera.view);
		camera_set_proj_mat(id, default_camera.proj);
	}
	static apply = function(){		
		camera_apply(id);
		
		var pos = position;
		if ( !first_person ) pos = target;
		shader_set_uniform_f(giz.d3d.shader.campos, pos.x, pos.y, pos.z);	
	}
	static forward = function(){
		return rotation.z + 90;	
	}
	update = function(){
		if ( proj == undefined ) proj = matrix_build_projection_perspective_fov(-fov, -aspect, near, far);
		if ( first_person ) {
			target.x = position.x + ( dcos(rotation.z) * dsin(rotation.y) );
			target.y = position.y + ( dsin(rotation.z) * dsin(rotation.y) );
			target.z = position.z + ( dcos(rotation.y) );
			view = matrix_build_lookat(position.x, position.y, position.z, target.x, target.y, target.z, up.x, up.y, up.z);
		} else {
			target.x = position.x - ( dcos(rotation.z) * dsin(rotation.y) * distance );
			target.y = position.y - ( dsin(rotation.z) * dsin(rotation.y) * distance );
			target.z = position.z - ( dcos(rotation.y) * distance );
			view = matrix_build_lookat(target.x, target.y, target.z, position.x, position.y, position.z, up.x, up.y, up.z);
		}
		camera_set_proj_mat(id, proj);
		camera_set_view_mat(id, view);
	}

}
function giz_d3d_environment() constructor {
	
	static enable = function(){
		giz.d3d.render.add(draw);
		
		shader			= giz_core_skybox;
		uvs				= shader_get_uniform(shader, "u_uvs");
		sun_direction	= [-1, 1, 1];
		sun_color		= [1, 1, 1];
		skybox			= giz.d3d.shader.sampler_create(giz_core_spr_tex_sky, 1, giz.d3d.shader.skybox, giz.d3d.shader.skybox_uvs);
		
		vec0			= giz.math.vec3(0);
		vec1024			= giz.math.vec3(1024);
		mesh			= giz.d3d.primitive.sphere;
		matrix			= giz.math.matrix(vec0, vec0, vec1024);
		
	}
	
	static set_skybox = function(_sprite=undefined){
		giz.d3d.shader.sampler_set(skybox, _sprite, 1);
	}
	static apply = function(){
		skybox.apply();
		shader_set_uniform_f_array(giz.d3d.shader.sundir, sun_direction);
		shader_set_uniform_f_array(giz.d3d.shader.suncol, sun_color);	
	}
	draw = function(){
		
		draw_clear(0);
		
		gpu_set_zwriteenable(false);
		shader_set(shader);
		shader_set_uniform_f(uvs, skybox.uvs[0], skybox.uvs[1], skybox.uvs[2]-skybox.uvs[0], skybox.uvs[3]-skybox.uvs[1]);
		mesh.submit(matrix, skybox.texture);
		shader_reset();
		gpu_set_zwriteenable(true);
		
	}
	
}
function giz_d3d_shader(_id=giz_core_pbr) constructor {
	
	id				= _id;
	campos			= shader_get_uniform(id, "u_campos");
	sundir			= shader_get_uniform(id, "u_sundir");
	suncol			= shader_get_uniform(id, "u_suncol");
	metalrough		= shader_get_sampler_index(id, "s_metalrough");
	emission		= shader_get_sampler_index(id, "s_emission");
	normal			= shader_get_sampler_index(id, "s_normal");
	skybox			= shader_get_sampler_index(id, "s_skybox");
	brdf			= shader_get_sampler_index(id, "s_brdf");
	emission_uvs	= shader_get_uniform(id, "u_emission_uvs");
	normal_uvs		= shader_get_uniform(id, "u_normal_uvs");
	skybox_uvs		= shader_get_uniform(id, "u_skybox_uvs");
	brdf_uvs		= shader_get_uniform(id, "u_brdf_uvs");
		
	static sampler_create = function(_sprite, _value, _uniform, _uv_uni=undefined){
		
		var mat = other;
		_sprite ??= giz_core_spr_tex_wht;
		_value	??= 1;
		if ( is_string(_uniform) ) _uniform = self[$ _uniform];
		
		var tex	 = sprite_get_texture(_sprite, 0);
		var suvs = sprite_get_uvs(_sprite, 0);
		return {
			material: mat,
			value	: _value,
			sprite	: _sprite,
			texture : tex,
			uvs		: [suvs[0], suvs[1], suvs[2]-suvs[0], suvs[3]-suvs[1]],
			uniform : _uniform,
			uv_uni	: _uv_uni,
			apply	: function(){
				if ( uv_uni != undefined ) shader_set_uniform_f_array(uv_uni, uvs);
				texture_set_stage(uniform, texture);	
			},
			reload	: function(){
				var suvs = sprite_get_uvs(sprite, 0);
				texture = sprite_get_texture(sprite, 0);
				uvs		= [suvs[0], suvs[1], suvs[2]-suvs[0], suvs[3]-suvs[1]];
			}
		}
	}
	static sampler_set = function(_sampler=undefined, _sprite=undefined, _value=undefined){
		if ( _sampler == undefined ) return;
		if ( is_struct(_sprite) ) {
			if ( _sprite.sprite == undefined ){
					array_push(_sprite.sample, _sampler);
					_sprite = _sampler.sprite;
			} else	_sprite = _sprite.sprite;
		}
		_sprite ??= _sampler.sprite;
		_value	??= _sampler.value;
		
		_sampler.sprite		= _sprite;
		_sampler.value		= clamp(_value, 0, 1);
		_sampler.reload();
	}
		
}
function giz_d3d_material() constructor {
	giz.d3d.cache(self);
	
	recompile		= false;
	shader			= giz_core_pbr;
	brdf			= giz.d3d.shader.sampler_create(giz_core_spr_brdf, 0, giz.d3d.shader.brdf, giz.d3d.shader.brdf_uvs);
	normal			= giz.d3d.shader.sampler_create(giz_core_spr_tex_nrm, 1, giz.d3d.shader.normal, giz.d3d.shader.normal_uvs);
	emission		= giz.d3d.shader.sampler_create(giz_core_spr_tex_blk, 0, giz.d3d.shader.emission, giz.d3d.shader.emission_uvs);
	texture			= giz.d3d.shader.sampler_create(giz_core_spr_tex_tex, 0);
	roughness		= giz.d3d.shader.sampler_create(giz_core_spr_tex_wht, 1);
	metallic		= giz.d3d.shader.sampler_create(giz_core_spr_tex_wht, 0);
	ambient			= giz.d3d.shader.sampler_create(giz_core_spr_tex_wht, 1);
	
	metalrough = { 
		surface		: -1, 
		texture		: undefined, 
		components	: [ ambient, metallic, roughness ],
		apply		: function(){
			texture_set_stage(giz.d3d.shader.metalrough, texture);
		}
	};	
	
	static set_sampler = function(_sampler=undefined, _sprite=undefined, _value=undefined){
		if ( is_string(_sampler) ) _sampler = self[$ _sampler];
		if ( _sampler == undefined ) return;
		
		giz.d3d.shader.sampler_set(_sampler, _sprite, _value);
		recompile = true;
		return self;
	}
	static set_value = function(_sampler, _value){
		if ( is_string(_sampler) ) _sampler = self[$ _sampler];
		if ( _sampler == undefined ) return;
		
		giz.d3d.shader.sampler_set(_sampler, undefined, _value);
		recompile = true;
		return self;
	}
	static compile_metalrough = function(){
		if ( recompile ) cleanup();
		
		if ( !surface_exists(metalrough.surface) ) {			
			var i = 0;
			var w = 1;
			var h = 1;
			repeat(array_length(metalrough.components)){
				var comp = metalrough.components[i++];
				w = max(w, sprite_get_width(comp.sprite));
				h = max(h, sprite_get_height(comp.sprite));
			}
			
			metalrough.surface = surface_create(w, h);
			surface_set_target(metalrough.surface);
			draw_clear(0);
			
			draw_sprite_stretched_ext(ambient.sprite, 0, 0, 0, w, h, #FF0000, 1);
			gpu_set_blendmode(bm_add);
			draw_sprite_stretched_ext(roughness.sprite, 0, 0, 0, w, h, #00FF00, roughness.value);
			draw_sprite_stretched_ext(metallic.sprite, 0, 0, 0, w, h, #0000FF, metallic.value);
			gpu_set_blendmode(bm_normal);
			
			surface_reset_target();
			
			metalrough.texture = surface_get_texture(metalrough.surface);
			recompile = false;
		}
	}
	static apply = function(){
		
		compile_metalrough();
		shader_set(shader);	
		
		giz.camera.apply();
		giz.d3d.environment.apply();		
		brdf.apply();
		normal.apply();
		emission.apply();
		metalrough.apply();
		
		gpu_set_tex_max_mip_ext(giz.d3d.shader.skybox, 0);
	}
	cleanup = function(){
		if ( surface_exists(metalrough.surface) ) surface_free(metalrough.surface);	
		show_debug_message("giz.d3d :: Material cleaned or recompiled!");
	}
}
function giz_d3d_primitives() constructor {
	
	format			= undefined;
	sphere			= undefined;
	plane			= undefined;
	cube			= undefined;
	cube_data		= [
	    // Verts
	    [[-1, 1, -1], [-1, -1, -1], [1, 1, -1], 
	    [1, -1, -1], [-1, -1, 1], [1, -1, 1],       
	    [-1, 1, 1], [1, 1, 1], [-1, 1, -1],         
	    [1, 1, -1], [-1, 1, -1], [-1, 1, 1],        
	    [1, 1,  -1], [1, 1, 1]], 
        
	    // Uvs
	    [[0, 0.66], [0.25, 0.66], [0, 0.33],    
	    [0.25, 0.33], [0.5, 0.66], [0.5, 0.33],     
	    [0.75, 0.66], [0.75, 0.33], [1, 0.66],      
	    [1, 0.33], [0.25, 1], [0.5, 1],             
	    [0.25, 0], [0.5, 0]],
        
	    // Normals
	    [[0, 0, -1], [0, 0, -1], [0, 0, 1],     
	    [0, 0, 1], [0, 1, 0], [0, 1, 0],            
	    [0, -1, 0], [0, -1, 0], [-1, 0, 0],         
	    [-1, 0, 0], [1, 0,0], [1, 0, 0] ],
        
	    // Triangles
	    [[0, 2, 1], [1, 2, 3], [4, 5, 6],       
	    [5, 7, 6], [6, 7, 8], [7, 9 ,8],            
	    [1, 3, 4], [3, 5, 4], [1, 11,10],           
	    [1, 4, 11], [3, 12, 5], [5, 12, 13]],       
	];

	static enable = function(){
		format			= format_create(["position3d", "normal", "texcoord", "tangent"]);
		sphere			= vertex_buffer_create_sphere(0.5, 32);
		plane			= vertex_buffer_create_plane(1, 1);
		cube			= vertex_buffer_create_cube(1, 1, 1);
	}
	cleanup = function(){
		if ( format == undefined ) return;
		format.cleanup();
		sphere.cleanup();
		plane.cleanup();
		cube.cleanup();
		
		show_debug_message("giz.d3d :: Primitives cleaned!");
	}
	
	// Format Function
	static format_create = function(format_array){
		var bytes = [];
	    vertex_format_begin();
		
		var i = 0;
	    repeat(array_length(format_array)){       
	        switch(format_array[i++]){
	        	case "position2d"	:	vertex_format_add_position();
										array_push(bytes, {type: buffer_f32, values: ["x", "y"]}); break;
	        	case "position3d"	:	vertex_format_add_position_3d();
										array_push(bytes, {type: buffer_f32, values: ["x", "y", "z"]}); break;
	        	case "normal"		:	vertex_format_add_normal();
										array_push(bytes, {type: buffer_f32, values: ["nx", "ny", "nz"]}); break;
	        	case "texcoord"		:	vertex_format_add_texcoord();
										array_push(bytes, {type: buffer_f32, values: ["u", "v"]}); break;
	        	case "color"		:	vertex_format_add_color();
										array_push(bytes, {type: buffer_u8,  values: ["r", "g", "b", "a"]}); break;
	        	case "tangent"		:	vertex_format_add_custom(vertex_type_float3, vertex_usage_texcoord);
										array_push(bytes, {type: buffer_f32, values: ["tx", "ty", "tz"]}); break;
	        	case "binormal"		:	vertex_format_add_custom(vertex_type_float3, vertex_usage_texcoord);
										array_push(bytes, {type: buffer_f32, values: ["bx", "by", "bz"]}); break;
				case "index"		:	vertex_format_add_custom(vertex_type_float2, vertex_usage_texcoord); 
										array_push(bytes, {type: buffer_f32, values: ["index", "index"]}); break;
	        }
	    }
		var _format = vertex_format_end();
	    return {
	    	id			: _format,
			size		: array_length(bytes),
	    	byte		: bytes,
			cleanup		: function(){
				vertex_format_delete(id);	
			}
	    }
	}
	
	// Vertex Functions
	static vertex_point = function(_x, _y, _z, _nx, _ny, _nz, _u, _v, _col=c_white, _alp=1){
	    return {
			x: _x, nx: _nx, u: _u,
			y: _y, ny: _ny, v: _v,
			z: _z, nz: _nz,
			r: color_get_red(_col),
			g: color_get_green(_col),
			b: color_get_blue(_col),
			a: _alp * 255
		}
	}
	static vertex_buffer_build_point = function(vb, vert, _format=undefined){
		_format ??= format;
	    var i = 0;
	    repeat(_format.size){
	    	var data = _format.byte[i];
	    	for ( var j=0; j<array_length(data.values); j++ ){
	    		buffer_write(vb, data.type, vert[$ data.values[j]]);
	    	}
	    	i++;
	    }
	}
	static vertex_buffer_build_tangent_binormal = function(vert_array){
		var v1 = vert_array[0], 
			v2 = vert_array[1], 
			v3 = vert_array[2];
		
		var	u1 = giz.math.vec2(v1.u, v1.v);
		var	u2 = giz.math.vec2(v2.u, v2.v);
		var	u3 = giz.math.vec2(v3.u, v3.v);
			v1 = giz.math.vec3(v1);
			v2 = giz.math.vec3(v2);
			v3 = giz.math.vec3(v3);
		
		var e1 = giz.math.subtract(v2, v1);
		var e2 = giz.math.subtract(v3, v1);
		var d1 = giz.math.subtract(u2, u1);
		var d2 = giz.math.subtract(u3, u1);
		var f  = 1. / (d1.x * d2.y - d2.x * d1.y);
		var t  = [
			f * ( d2.y * e1.x - d1.y * e2.x ),
			f * ( d2.y * e1.y - d1.y * e2.y ),
			f * ( d2.y * e1.z - d1.y * e2.z )
		];
		var b  = [
			f * (-d2.x * e1.x + d1.x * e2.x ),
			f * (-d2.x * e1.y + d1.x * e2.y ),
			f * (-d2.x * e1.z + d1.x * e2.z )
		];
	
		return {
			tangent : t,
			binormal: b
		}
	}
	static vertex_buffer_build_triangle = function(vb, vert_array, _format=undefined){
		_format ??= format;
		var tans = vertex_buffer_build_tangent_binormal(vert_array);
	
		var i = 0;
		repeat(3){
			vert_array[i].tx = tans.tangent[0]; vert_array[i].bx = tans.binormal[0];
			vert_array[i].ty = tans.tangent[1]; vert_array[i].by = tans.binormal[1];
			vert_array[i].tz = tans.tangent[2]; vert_array[i].bz = tans.binormal[2];
			vert_array[i].tw = 1; vert_array[i].bw = 1;
			vertex_buffer_build_point(vb, vert_array[i], _format);
			i++;
		}
	}
	static vertex_buffer_build_quad = function(vb, v1, v2, v3, v4, _format=undefined){
	    _format ??= format;
		vertex_buffer_build_triangle(vb, [v1, v2, v3], _format);
	    vertex_buffer_build_triangle(vb, [v1, v3, v4], _format);
	}
	
	// Primitive Builder Functions
	static vertex_buffer_object = function(buff, _format=undefined){
		_format ??= format;
		var vbuff = vertex_create_buffer_from_buffer(buff, _format.id);
		vertex_freeze(vbuff);
		return {
			buffer			: buff,
			vertex_buffer	: vbuff,
			
			submit			: function(_matrix=undefined, _texture=-1){
				if ( _matrix != undefined ) matrix_set(matrix_world, _matrix);
				vertex_submit(vertex_buffer, pr_trianglelist, _texture);
			},
			cleanup			: function(){
				buffer_delete(buffer);
				vertex_delete_buffer(vertex_buffer);
			}	
		}
	}
	static vertex_buffer_load = function(file, _format=undefined){
		_format ??= format;
		var buffer = buffer_load(file);
		
		return vertex_buffer_object(buffer, _format);
	}
	static vertex_buffer_create_sphere = function(radius, steps, _format=undefined){
		_format ??= format;
		var _x, _y, _z, _xy, k1, k2;
		var _ln=1/radius;
		var vert = [];
	
		for ( var i=0; i<=steps; ++i ){
			var stack_angle = pi/2 - i * (pi/steps);
			_xy = radius * cos(stack_angle);
			_z  = radius * sin(stack_angle);
		
			if ( i == 0 || i == steps-1 ) _xy = 0;
		
			for ( var j=0; j<=steps; ++j ){
				var slice_angle = j*(2*pi/steps);
				_x = _xy*cos(slice_angle);
				_y = _xy*sin(slice_angle);
				array_push(vert, vertex_point(_x, _y, _z, _x*_ln, _y*_ln, _z*_ln, j/steps, i/steps));
			}
		}
		var buffer = buffer_create(1, buffer_grow, 1);
		for ( var i=0; i<steps; ++i ){
			k1 = i * (steps+1);
			k2 = k1 + steps + 1;
			for ( var j=0; j<steps; ++j ){
				if ( i != 0 ) vertex_buffer_build_triangle(buffer, [vert[k1], vert[k2], vert[k1+1]], _format);
				if ( i != steps-1) vertex_buffer_build_triangle(buffer, [vert[k1+1], vert[k2], vert[k2+1]], _format);
				k1++; k2++; 
			}
		}
		
		return vertex_buffer_object(buffer, _format);
	}
	static vertex_buffer_create_plane = function(width, height, _format=undefined){
	    _format ??= format;
		var _w = width*.5, _h = height*.5;
	    var buffer = buffer_create(1, buffer_grow, 1);
	    vertex_buffer_build_quad(buffer, 
	        vertex_point(-_w, -_h, 0, 0, 0, 1, 0, 0),
	        vertex_point(_w, -_h, 0, 0, 0, 1, 1, 0),
	        vertex_point(_w, _h, 0, 0, 0, 1, 1, 1),
	        vertex_point(-_w, _h, 0, 0, 0, 1, 0, 1), _format
	    );

		return vertex_buffer_object(buffer, _format);
	}
	static vertex_buffer_create_cube = function(width, height, _depth, _format=undefined){
	    _format ??= format;
		var _w = width*.5, _h = height*.5, _d = _depth*.5;
		
		var data = cube_data;
	    var buffer = buffer_create(1, buffer_grow, 1);
	    for ( var i=0; i<array_length(data[3]); i++ ){
	        var t = data[3][i]; // vert
	        var n = data[2][i]; // norm
        
	        var v1 = data[0][t[0]], v2 = data[0][t[1]], v3 = data[0][t[2]]; // vert
	        var u1 = data[1][t[0]], u2 = data[1][t[1]], u3 = data[1][t[2]]; // uvs
        
	        var p1 = vertex_point(v1[0]*_w, v1[1]*_h, v1[2]*_d, n[0], n[1], n[2], u1[0], u1[1]);
	        var p2 = vertex_point(v2[0]*_w, v2[1]*_h, v2[2]*_d, n[0], n[1], n[2], u2[0], u2[1]);
	        var p3 = vertex_point(v3[0]*_w, v3[1]*_h, v3[2]*_d, n[0], n[1], n[2], u3[0], u3[1]);
	        vertex_buffer_build_triangle(buffer, [p1, p2, p3], _format);
	    }
		return vertex_buffer_object(buffer, _format);
	}
	
}