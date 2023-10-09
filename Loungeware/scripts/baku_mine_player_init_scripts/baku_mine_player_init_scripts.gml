enum baku_mine_ore_type { diamond, emerald, gold, redstone, iron, __size }
enum baku_mine_light_param { x, y, z, radius, r, g, b, alpha, null }

function baku_mine_player_init_gamestate(){
	//show_debug_overlay(true);
	
	// Game state
	win						= false;
	win_confetti_time		= 0;
	win_confetti_timer		= 5;
	lose					= false;
	timer_skip_time			= 0;
	timer_skip_threshold	= game_get_speed(gamespeed_fps) * 4;
}
function baku_mine_player_init_playersize(){
	// Player size
	z					= 0;
	height				= 30;
	eye_height			= 20;
}
function baku_mine_player_init_movement(){
	// Movement
	acc					= 0.5;
	fric				= 0.5;
	max_spd				= 2;
	jump_spd			= 3;
	fall_spd			= 3;
	grav				= 0.2;
	min_z				= 0;
	spd					= 0;
	x_spd				= 0;
	y_spd				= 0;
	z_spd				= 0;
	grounded			= 0;
	fb_vel				= 0;
	rl_vel				= 0;
	moving				= false;
}
function baku_mine_player_init_headbob(){
	// Head bob
	head_bob			= 0;
	head_bob_lerped		= 0;
	head_bob_time		= 0;
	head_bob_time_mod	= 15;
}
function baku_mine_player_init_aim(){
	// Aim
	aim_spd				= 2;
	aim_dir				= 90;
	aim_pitch			= -10;
	block_aim_id		= noone;
	block_aim_max_dis	= 64;
	block_aim_timer		= 1;	// Only check for blocks ever "x" frame
	block_aim_time		= 5;
}
function baku_mine_player_init_pickaxe(){
	// Pickaxe
	pick_rot			= 0;
	pick_rot_lerped		= 0;
	pick_time_mod		= 15;
	pick_time			= pick_time_mod - 1;
	crack_img			= 0;	
}
function baku_mine_player_init_creeper(){
	// Creeper
	creeper_spawned		= false;
	creeper_dir			= 0;
	creeper_aim_dir		= 0;
	creeper_aim_lerp	= 0.1;
	roundabout_started	= false;
	creeper_flash		= 0;
	creeper_flash_spd	= 22.5;
	show_alt_creeper	= irandom(14) == 14; // uwu //	
}
function baku_mine_player_init_prompt(){
	// NEW prompt gui stuff
	prompt_wait = 30;
	prompt_scale = 2;
	prompt_lerp = 0.1;
	prompt_x = 480 / 2;
	prompt_y = (270 / 2) + 25;
	prompt_col = c_gbwhite;
	prompt_col_merge = 0;
	prompt_shake = -1;
	
	// Struct holding prompt → ore type relations (sexy)
	prompt_to_ore_translator = {};
	prompt_to_ore_translator[$ "MINE DIAMOND"]	= baku_mine_ore_type.diamond;
	prompt_to_ore_translator[$ "MINE EMERALD"]	= baku_mine_ore_type.emerald;
	prompt_to_ore_translator[$ "MINE GOLD"]		= baku_mine_ore_type.gold;
	prompt_to_ore_translator[$ "MINE RUBY"]		= baku_mine_ore_type.redstone;
	prompt_to_ore_translator[$ "MINE IRON"]		= baku_mine_ore_type.iron;
	
	// Struct holding prompt → drop sprite relations (just as sexy)
	// prompt_to_drop_translator = {};
	// prompt_to_drop_translator[$ "MINE DIAMOND"]		= baku_mine_spr_diamond_drop;
	// prompt_to_drop_translator[$ "MINE EMERALD"]		= baku_mine_spr_emerald_drop;
	// prompt_to_drop_translator[$ "MINE GOLD"]		= baku_mine_spr_gold_drop;
	// prompt_to_drop_translator[$ "MINE RUBY"]		= baku_mine_spr_redstone_drop;
	// prompt_to_drop_translator[$ "MINE IRON"]		= baku_mine_spr_iron_drop;
	
	// Prompt setup
	prompt_setup_done = false;
}

function baku_mine_player_init_levelgen(){
	
	// Level size
	level_w = 24;
	level_h = 32;
	level_layer_height = 16;
	block_w = 16;
	block_h = 16;
	
	// Layers
	level_layer_count = 11;
	for (var i = 0; i < level_layer_count; ++i) {
		layer_create(0, string(i));
	}
	
	// Create level surface
	var _surf_w = sprite_get_width(baku_mine_spr_level_grid);
	var _surf_h = sprite_get_height(baku_mine_spr_level_grid);
	var _level_surf = surface_create(_surf_w, _surf_h);
	surface_set_target(_level_surf);
	draw_sprite(baku_mine_spr_level_grid, 0, 0, 0);
	surface_reset_target();
	
	// Create buffer
	var _level_buffer = buffer_create(_surf_w * _surf_h * 4, buffer_fast, 1);
	buffer_get_surface(_level_buffer, _level_surf, 0);
	
	// Read buffer and create blocks
	for (var i = 0; i < _surf_w * _surf_h; ++i) {
		// Calculate layer, x and y
		var _pos	= i * 4;
		var _x		= (i mod level_w) * block_w;
		var _y		= ((i div level_w) mod level_h) * block_h;
		var _layer	= i div (level_w * level_h);
		var _z		= _layer * level_layer_height;
		
		// Read colour
		var _r = buffer_peek(_level_buffer, _pos,		buffer_u8);
		var _g = buffer_peek(_level_buffer, _pos + 1,	buffer_u8);
		var _b = buffer_peek(_level_buffer, _pos + 2,	buffer_u8);
		var _col = make_colour_rgb(_r, _g, _b);
		
		//0000FF
		
		// Normal boring blocks
		if _col == 0x000000 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_par_solid); _inst.cull = true; _inst.z = _z; _inst.texture_name = choose("stone", "stone_dark"); }
		if _col == 0x0000ff { var _inst = instance_create_layer(_x, _y, layer, baku_mine_par_solid); _inst.cull = true; _inst.z = _z; _inst.texture_name = choose("dirt", "dirt_dark"); }
		if _col == 0x0080ff { var _inst = instance_create_layer(_x, _y, layer, baku_mine_par_solid); _inst.cull = true; _inst.z = _z; _inst.texture_name = "table"; }
		if _col == 0x808080 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_par_solid); _inst.cull = true; _inst.z = _z; _inst.texture_name = "furnace"; }
		if _col == 0x008080 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_par_solid); _inst.cull = true; _inst.z = _z; _inst.texture_name = "ladder"; }
		
		// Special blocks
		if _col == 0xffff00 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_ore);		_inst.z = _z; }
		if _col == 0xff0000 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_creeper_or_stone);	_inst.z = _z; }
		if _col == 0x00ffff { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_sign);		_inst.z = _z; }
		
		// Torches
		if _col == 0x80ff80 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_torch);	_inst.z = _z;	_inst.image_angle = 0;		} // North
		if _col == 0x808000 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_torch);	_inst.z = _z;	_inst.image_angle = 90;		} // West
		if _col == 0x800080 { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_torch);	_inst.z = _z;	_inst.image_angle = 180;	} // South
		if _col == 0x8080ff { var _inst = instance_create_layer(_x, _y, layer, baku_mine_obj_block_torch);	_inst.z = _z;	_inst.image_angle = 270;	} // East
		
		// Player
		if _col == 0x00ff00 {
			x = _x; 
			y = _y;
			z = _z;
		}
	}
		
	// Cleanup
	buffer_delete(_level_buffer);
	surface_free(_level_surf);
}
function baku_mine_player_init_static_geometry(){
		
	var filepath	= "baku/baku_mine/baku_mine_model_level.vbuff";
	matrix_static	= matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	
	// Load?
	if ( file_exists(filepath) ) {
		var buff = buffer_load(filepath);
		vb_static = vertex_create_buffer_from_buffer(buff, format);
		vertex_freeze(vb_static);
		buffer_delete(buff);
		show_debug_message("baku_mine :: Loaded!");
		return;
	}
	
	// Generate
	vb_static = vertex_create_buffer();
	vertex_begin(vb_static, format);
	
	// Blocks
	with ( baku_mine_par_solid ) { 
		if ( is_ore ) continue;
		var texcoords = other.textures[$ texture_name];
		baku_mine_model_block_static(other.vb_static, x, y, z, {
			x : texcoords.x,
			y : texcoords.y + texcoords.h,
			w : texcoords.w,
			h : -texcoords.h
		});
	}
	
	vertex_end(vb_static);
	buffer_save(buffer_create_from_vertex_buffer(vb_static, buffer_fixed, 1), filepath);
	vertex_freeze(vb_static);
	show_debug_message("baku_mine :: Generated!");
}
function baku_mine_player_init_3d(){
	// Grab pre-3D settings
	old_zwriteenable				= gpu_get_zwriteenable();
	old_ztestenable					= gpu_get_ztestenable();
	old_cullmode					= gpu_get_cullmode();
	old_alphatestenable				= gpu_get_alphatestenable();
	old_layer_forced_depth			= layer_get_forced_depth();
	old_layer_is_draw_depth_forced	= layer_is_draw_depth_forced();
	
	// Enable 3D func
	enable_3d = function() {
		gpu_set_zwriteenable(true);
		gpu_set_ztestenable(true);
		//gpu_set_cullmode(cull_clockwise);
		gpu_set_alphatestenable(true);
		layer_force_draw_depth(true, 0);
	}
	
	// Disable 3D func
	disable_3d = function() {
		gpu_set_zwriteenable(old_zwriteenable);
		gpu_set_ztestenable(old_ztestenable);
		gpu_set_cullmode(old_cullmode);
		gpu_set_alphatestenable(old_alphatestenable);
		layer_force_draw_depth(old_layer_is_draw_depth_forced, old_layer_forced_depth);
	}
	
	// 3D format
	enable_3d();
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_color();
	vertex_format_add_texcoord();
	format = vertex_format_end();
	
	// Load 3D models
	baku_mine_model_block();
	baku_mine_model_torch();
	baku_mine_model_plane();
	
	// Identity matrix
	i_matrix = matrix_build_identity();
	
	// Draw vertex buffer func
	draw_vertex_buffer = function(_v_buff, _prim, _texture, _x, _y, _z, _x_rot, _y_rot, _z_rot, _x_scale, _y_scale, _z_scale, _matrix) {
		var _mat = matrix_build(_x, _y, _z, _x_rot, _y_rot, _z_rot, _x_scale, _y_scale, _z_scale);
		matrix_set(_matrix, _mat);
		vertex_submit(_v_buff, _prim, _texture);
	}
	draw_vertex_buffer_simple = function(_v_buff, _mat, _tex){
		matrix_set(matrix_world, _mat);	
		vertex_submit(_v_buff, pr_trianglelist, _tex);
	}	
}
function baku_mine_player_init_camera(){
	// Camera struct
	cam = {
		cam			: -1,
		proj_mat	: -1,
		
		fov			: -60,
		aspect		: -480 / 320,
		z_near		: 1,
		z_far		: 1000,
		x_up		: 0,
		y_up		: 0,
		z_up		: 1,
		
		x_from		: 0,
		y_from		: 0,
		z_from		: 0,
		x_to		: 0,
		y_to		: 0,
		z_to		: 0,
		
		display		: -1
	}
	
	// Create camera
	cam.cam = camera_create();
	cam.proj_mat = matrix_build_projection_perspective_fov(cam.fov, cam.aspect, cam.z_near, cam.z_far);
	camera_set_proj_mat(cam.cam, cam.proj_mat);
	
	// Surface
	cam.display = surface_create(480, 320);

}
function baku_mine_player_init_collisions(){
	// """3D place_meeting""" (quotation marks for days)
	
	start_collision = false;
	collision_list = ds_list_create();
	place_meeting_3d = function(_x, _y, _z, _obj) {
		ds_list_clear(collision_list);
		
		var _z_min	= _z;
		var _z_max	= _z + height;
		var _return = false;
		var _num	= instance_place_list(_x, _y, _obj, collision_list, false);
		
		// If we're colliding
		var _list	= collision_list;
		if _num > 0 {
			// Loop through collisions
			for (var i = 0; i < _num; ++i;) {
				
				// Check for z collision
				var _block = _list[| i];
				if ( _z_min < _block.z + _block.height ) && ( _z_max > _block.z ){
					_return = true;
					break;
				}
				
			}
		}
		return _return;
	}
	
	// Getting the block we're looking at
	collision_line_list_3d_first = function(_x, _y, _z, _x2, _y2, _obj) {
		ds_list_clear(collision_list);
		
		var _z_min	= _z;
		var _z_max	= _z;
		var _return = noone;
		var _num	= collision_line_list(_x, _y, _x2, _y2, _obj, false, true, collision_list, true);
		
		// If we're colliding
		var _list	= collision_list;
		if _num > 0 {
			// Loop through collisions
			for (var i = 0; i < _num; ++i;) {
				
				// Check for z collision
				var _block = _list[| i];
				if (_z_min < _block.z + _block.height) and (_z_max > _block.z) {
					_return = _block;
					break;
				}
				
			}
		}
		//ds_list_destroy(_list);
		return _return;
	}	
}
function baku_mine_player_init_lights(){
		
	// Create light func
	light_update	= 1;	// Only update lighting every 'x' frames
	light_frame		= 5;	
	light_col		= [];
	light_pos		= [];
	light_number	= 0;
	light_create	= function(_x=0, _y=0, _z=0, _rad=0, _col=c_white, _alp=0) {

		var _r = colour_get_red(_col);
		var _g = colour_get_green(_col);
		var _b = colour_get_blue(_col);
		var _l = {
			index	: baku_mine_obj_player.light_number * 4,
			set		: function(_name, _val){
				switch(_name){
					
					case "x"		: baku_mine_obj_player.light_pos[index]		= _val; break;
					case "y"		: baku_mine_obj_player.light_pos[index+1]	= _val; break;
					case "z"		: baku_mine_obj_player.light_pos[index+2]	= _val; break;
					case "radius"	: baku_mine_obj_player.light_pos[index+3]	= _val; break;
					case "alpha"	: baku_mine_obj_player.light_col[index+3]	= _val; break;
					case "color"	: 
					
						baku_mine_obj_player.light_col[index]	= color_get_red(_val);
						baku_mine_obj_player.light_col[index+1] = color_get_green(_val);
						baku_mine_obj_player.light_col[index+2] = color_get_blue(_val);
							  
					break;	  
				}	
			},
			set_all : function(_x, _y, _z, _rad, _col, _alp){
				set("x", _x);
				set("y", _y);
				set("z", _z);
				set("radius", _rad);
				set("color", _col);
				set("alpha", _alp);
			},
			destroy	: function(){
				baku_mine_obj_player.light_number--;
				array_delete(baku_mine_obj_player.light_pos, index, 4);
				array_delete(baku_mine_obj_player.light_col, index, 4);
			}
		}
		array_push(light_col, _x, _y, _z, _rad);
		array_push(light_pos, _r, _g, _b, _alp);
		baku_mine_obj_player.light_number++;
		return _l;
	}
	
	// Creeper Lighting
	creeper_light = light_create();
	with ( baku_mine_obj_block_ore ) light = other.light_create(x, y, z, 32, glow_col, glow_alpha); 
	with ( baku_mine_obj_block_torch ) light = other.light_create(x, y, z, 64 + random_range(-4, 4), 0x3389ff, random_range(0.3, 0.35));
	with ( baku_mine_obj_creeper_or_stone ) light = other.light_create(x, y, z, 32, glow_col, glow_alpha);
	
}
function baku_mine_player_init_textures(){
	
	texpage = sprite_get_texture(baku_mine_texture, 0);
	
	// Texture data constructer
	Texture = function(_x, _y, _w, _h) constructor {
		x = _x;
		y = _y;
		w = _w;
		h = _h;
	}
	
	// Struct with texture data
	textures = {};
	
	textures.stone			= new Texture(64*0, 64*0, 64, 64);
	textures.stone_dark		= new Texture(64*1, 64*0, 64, 64);
	textures.stone_darker	= new Texture(64*2, 64*0, 64, 64);
	textures.dirt			= new Texture(64*3, 64*0, 64, 64);
	textures.dirt_dark		= new Texture(64*4, 64*0, 64, 64);
	
	textures.ore_diamond	= new Texture(64*0, 64*1, 64, 64);
	textures.ore_emerald	= new Texture(64*1, 64*1, 64, 64);
	textures.ore_gold		= new Texture(64*2, 64*1, 64, 64);
	textures.ore_redstone	= new Texture(64*3, 64*1, 64, 64);
	textures.ore_iron		= new Texture(64*4, 64*1, 64, 64);
	
	textures.torch			= new Texture(64*0, 64*2, 64, 64);
	textures.signpost		= new Texture(64*1, 64*2, 64, 64);
	textures.table			= new Texture(64*2, 64*2, 64, 64);
	textures.furnace		= new Texture(64*3, 64*2, 64, 64);
	textures.ladder			= new Texture(64*4, 64*2, 64, 64);
	
	textures.creeper_face	= new Texture(64*0, 64*3, 64, 64);
	textures.creeper_body	= new Texture(64*1, 64*3, 64, 64);
	textures.creeper_ear	= new Texture(64*2, 64*3, 64, 64);
	
	textures.crackk_0		= new Texture(64*0, 64*4, 64, 64);
	textures.crackk_1		= new Texture(64*1, 64*4, 64, 64);
	textures.crackk_2		= new Texture(64*2, 64*4, 64, 64);
	textures.crackk_3		= new Texture(64*3, 64*4, 64, 64);
	textures.crackk_4		= new Texture(64*4, 64*4, 64, 64);
	textures.crackk_5		= new Texture(64*5, 64*4, 64, 64);
	textures.highlight		= new Texture(64*6, 64*4, 64, 64);
	
	textures.creeper_alt	= new Texture(64*0, 64*5, 128, 128);
	
	textures.sign_msg_0		= new Texture(64*0, 64*7, 64, 64);
	textures.sign_msg_1		= new Texture(64*1, 64*7, 64, 64);
	textures.sign_msg_2		= new Texture(64*2, 64*7, 64, 64);
	textures.sign_msg_3		= new Texture(64*3, 64*7, 64, 64);
	textures.sign_msg_4		= new Texture(64*4, 64*7, 64, 64);
	
	textures.pickaxe		= new Texture(480, 464, 32, 32);
	textures.drop_diamond	= new Texture(416+(16*0), 496, 16, 16);
	textures.drop_emerald	= new Texture(416+(16*1), 496, 16, 16);
	textures.drop_gold		= new Texture(416+(16*2), 496, 16, 16);
	textures.drop_redstone	= new Texture(416+(16*3), 496, 16, 16);
	textures.drop_iron		= new Texture(416+(16*4), 496, 16, 16);
	textures.drop_shadow	= new Texture(416+(16*5), 496, 16, 16);	
}
function baku_mine_player_init_shaders(){
	
	baku_mine_uniform = function(_shader, _uname, _value, _integer=false) constructor {
		uniform = shader_get_uniform(_shader, _uname);
		is_int	= _integer;
		
		static verify	= function(_value){
			if ( is_array(_value) ) return _value;
			return [_value];
		}
		static set		= function(_value=undefined){
			_value ??= value;
			value = verify(_value);
			apply();
		}	
		static texdata	= function(_tex){
			set([_tex.x, _tex.y, _tex.w, _tex.h]);
		}
		static apply	= function(){
			if ( is_int )	shader_set_uniform_i_array(uniform, value);
			else			shader_set_uniform_f_array(uniform, value);
		}

		value = verify(_value);
	}
	baku_mine_sampler = function(_shader, _uname, _tex) constructor {
		uniform = shader_get_sampler_index(_shader, _uname);
		texture	= _tex;
		
		static set = function(_texture=undefined){
			_texture ??= texture;
			texture = _texture;
			apply();
		}
		static apply = function(){
			texture_set_stage(uniform, texture);	
		}
	}
	
	// Main 3D shader
	baku_mine_shader_3d = {
		shader	: baku_mine_sh_3d,
		set		: function(){
			shader_set(shader);
		},
		uniform: {
			light_num			: new baku_mine_uniform(baku_mine_sh_3d, "light_num", 0, true),
			crack_img			: new baku_mine_uniform(baku_mine_sh_3d, "crack_img", 0),
			outline_alpha		: new baku_mine_uniform(baku_mine_sh_3d, "outline_alpha", 0),
			roundabout_active	: new baku_mine_uniform(baku_mine_sh_3d, "roundabout_active", false),
			roundabout_col		: new baku_mine_uniform(baku_mine_sh_3d, "roundabout_col", [colour_get_red(0x2b75cf) / 255, colour_get_green(0x2b75cf) / 255, colour_get_blue(0x2b75cf) / 255]),
			tex_data			: new baku_mine_uniform(baku_mine_sh_3d, "tex_data", [0, 0, 1, 1]),
			light_pos			: new baku_mine_uniform(baku_mine_sh_3d, "light_pos", [0, 0, 0, 0]),
			light_col			: new baku_mine_uniform(baku_mine_sh_3d, "light_col", [0, 0, 0, 0]),
			raw_coord			: new baku_mine_uniform(baku_mine_sh_3d, "raw_coord", 0),
			outline_tex			: new baku_mine_sampler(baku_mine_sh_3d, "outline_tex", sprite_get_texture(baku_mine_spr_highlight, 0))
		}
	}
	
	// Billboard shader
	baku_mine_shader_billboard = {
		shader	: baku_mine_sh_billboard,	
		set		: function(){
			shader_set(shader)	
		},
		uniform	: {
			roundabout_active	: new baku_mine_uniform(baku_mine_sh_3d, "roundabout_active", false),
			roundabout_col		: new baku_mine_uniform(baku_mine_sh_3d, "roundabout_col", [colour_get_red(0x2b75cf) / 255, colour_get_green(0x2b75cf) / 255, colour_get_blue(0x2b75cf) / 255]),
		}
	}
	
	
}

function baku_mine_player_init_gui(){
	gui_scale_x = 0.1083; // look at these delicious magic numbers :'D
	gui_scale_y = 0.0722;
	gui_scale_z = 1;	
}
function baku_mine_player_init_utils(){
	approach = function(_val1, _val2, _inc) {
		if (_inc < 0) throw("approach: amount is negative");
		return (_val1 + clamp(_val2 - _val1, -_inc, _inc));
	}	
}