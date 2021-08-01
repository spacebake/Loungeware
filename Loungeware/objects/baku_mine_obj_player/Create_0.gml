
// Debug timer
// microgame_set_timer_max(999);

// Game state
win					= false;
lose				= false;
win_confetti_time	= 0;
win_confetti_timer	= 5;

// Player size
z					= 0;
height				= 30;
eye_height			= 20;

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

// Head bob
head_bob			= 0;
head_bob_lerped		= 0;
head_bob_time		= 0;
head_bob_time_mod	= 15;

// Aim
aim_spd				= 2;
aim_dir				= 90;
aim_pitch			= -10;
block_aim_id		= noone;
block_aim_max_dis	= 64;

// Pickaxe
pick_rot			= 0;
pick_rot_lerped		= 0;
pick_time_mod		= 15;
pick_time			= pick_time_mod - 1;
crack_img			= 0;

// Sound stuff
think_spawned		= false;

// Creeper
creeper_spawned		= false;
creeper_dir			= 0;
creeper_aim_dir		= 0;
creeper_aim_lerp	= 0.1;
roundabout_started	= false;
creeper_flash		= 0;
creeper_flash_spd	= 22.5;

#region Prompt stuff
	
	// Debug
	show_debug_message("prompt: " + string(PROMPT));
	
	// Ore types
	enum baku_mine_ore_type { diamond, emerald, gold, redstone, iron, __size }
	
	// Struct holding prompt → ore type relations (sexy)
	prompt_to_ore_translator = {};
	prompt_to_ore_translator[$ "MINE DIAMOND"]	= baku_mine_ore_type.diamond;
	prompt_to_ore_translator[$ "MINE EMERALD"]	= baku_mine_ore_type.emerald;
	prompt_to_ore_translator[$ "MINE GOLD"]		= baku_mine_ore_type.gold;
	prompt_to_ore_translator[$ "MINE RUBY"]		= baku_mine_ore_type.redstone;
	prompt_to_ore_translator[$ "MINE IRON"]		= baku_mine_ore_type.iron;
	
	// Struct holding prompt → drop sprite relations (just as sexy)
	prompt_to_drop_translator = {};
	prompt_to_drop_translator[$ "MINE DIAMOND"]		= baku_mine_spr_diamond_drop;
	prompt_to_drop_translator[$ "MINE EMERALD"]		= baku_mine_spr_emerald_drop;
	prompt_to_drop_translator[$ "MINE GOLD"]		= baku_mine_spr_gold_drop;
	prompt_to_drop_translator[$ "MINE RUBY"]		= baku_mine_spr_redstone_drop;
	prompt_to_drop_translator[$ "MINE IRON"]		= baku_mine_spr_iron_drop;
	
	// Prompt setup
	prompt_setup_done = false;
	
#endregion

#region Level Generation
	
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
		
		// Normal boring blocks
		// if _col == 0x000000 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_stone);			_inst.z = _z; }
		// if _col == 0x0000ff { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_dirt);			_inst.z = _z; }
		if _col == 0x000000 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_par_solid);				_inst.z = _z;	_inst.tex = choose(baku_mine_spr_stone, baku_mine_spr_stone_dark); }
		if _col == 0x0000ff { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_par_solid);				_inst.z = _z;	_inst.tex = choose(baku_mine_spr_dirt, baku_mine_spr_dirt_dark); }
		if _col == 0x0080ff { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_par_solid);				_inst.z = _z;	_inst.tex = baku_mine_spr_table; }
		if _col == 0x808080 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_par_solid);				_inst.z = _z;	_inst.tex = baku_mine_spr_furnace; }
		if _col == 0x008080 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_par_solid);				_inst.z = _z;	_inst.tex = baku_mine_spr_ladder; }
		
		// Special blocks
		if _col == 0xffff00 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_ore);			_inst.z = _z; }
		if _col == 0xff0000 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_creeper_or_stone);	_inst.z = _z; }
		if _col == 0x00ffff { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_sign);			_inst.z = _z; }
		
		// Torches
		if _col == 0x80ff80 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_torch);			_inst.z = _z;	_inst.image_angle = 0;		} // North
		if _col == 0x808000 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_torch);			_inst.z = _z;	_inst.image_angle = 90;		} // West
		if _col == 0x800080 { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_torch);			_inst.z = _z;	_inst.image_angle = 180;	} // South
		if _col == 0x8080ff { var _inst = instance_create_layer(_x, _y, string(_layer), baku_mine_obj_block_torch);			_inst.z = _z;	_inst.image_angle = 270;	} // East
		
		// Player
		if _col == 0x00ff00 {
			x = _x; 
			y = _y;
			z = _z;
		}
	}
	
	// Cleanup
	// surface_save(_level_surf, "surf.png");		// Debug
	// buffer_save(_level_buffer, "buffer.sav");	// Debug
	buffer_delete(_level_buffer);
	surface_free(_level_surf);
	
#endregion

#region 3D junk
	
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
		gpu_set_cullmode(cull_counterclockwise);
		gpu_set_alphatestenable(true);
		layer_force_draw_depth(true, 0);
		// gpu_set_texrepeat(true);
		// gpu_set_tex_mip_enable(mip_on);
		// gpu_set_texfilter(false);
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
		// matrix_set(_matrix, i_matrix); // Moved out of function for performance
	}
	
#endregion

#region Camera
	
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
	}
	
	// Create camera
	cam.cam = camera_create();
	set_camera = function() {
		cam.proj_mat = matrix_build_projection_perspective_fov(cam.fov, cam.aspect, cam.z_near, cam.z_far);
		camera_set_proj_mat(cam.cam, cam.proj_mat);
		view_set_camera(VIEW_NUMBER, cam.cam);
	}
	
#endregion

#region Collision functions

	// """3D place_meeting""" (quotation marks for days)
	place_meeting_3d = function(_x, _y, _z, _obj) {
		var _z_min = _z;
		var _z_max = _z + height;
		var _return = false;
		var _list = ds_list_create();
		var _num = instance_place_list(_x, _y, _obj, _list, false);
		
		// If we're colliding
		if _num > 0 {
			// Loop through collisions
			for (var i = 0; i < _num; ++i;) {
				// Check for z collision
				with (_list[| i]) {
					if (_z_min < z + height) and (_z_max > z) {
						_return = true;
						break;
					}
				}
			}
		}
		ds_list_destroy(_list);
		return _return;
	}
	
	// Getting the block we're looking at
	collision_line_list_3d_first = function(_x, _y, _z, _x2, _y2, _obj) {
		var _z_min = _z;
		var _z_max = _z;
		var _return = noone;
		var _list = ds_list_create();
		var _num = collision_line_list(_x, _y, _x2, _y2, _obj, false, true, _list, true);
		
		// If we're colliding
		if _num > 0 {
			// Loop through collisions
			for (var i = 0; i < _num; ++i;) {
				// Check for z collision
				with (_list[| i]) {
					if (_z_min < z + height) and (_z_max > z) {
						_return = id;
						break;
					}
				}
			}
		}
		ds_list_destroy(_list);
		return _return;
	}

#endregion

#region Lights
	
	// Lights enum
	enum baku_mine_light { x, y, z, radius, r, g, b, a }
	
	// Create light func
	create_light = function(_x = 0, _y = 0, _z = 0, _radius = 0, _col = c_white, _a = 0) {
		var _r = colour_get_red(_col);
		var _g = colour_get_green(_col);
		var _b = colour_get_blue(_col);
		return [_x, _y, _z, _radius, _r, _g, _b, _a];
	}
	
	// Lights array
	MAX_LIGHT_COUNT = 32;
	clear_lights = function() {
		lights = [];
		light_pos = [];
		light_col = [];
	}
	clear_lights();
	
#endregion

#region "GUI"
	
	// Gui surface
	surf_gui = -1;
	create_gui_surf = function() {
		surf_gui = surface_create(480, 320);
	}
	gui_scale_x = 0.1083; // look at these delicious magic numbers :'D
	gui_scale_y = 0.0722;
	gui_scale_z = 1;
	
#endregion

#region Functions
	
	approach = function(_val1, _val2, _inc) {
		if (_inc < 0) throw("approach: amount is negative");
		return (_val1 + clamp(_val2 - _val1, -_inc, _inc));
	}
	
#endregion

// "Frustum culler"
instance_create_layer(x, y, layer, baku_mine_obj_frustum_culler);