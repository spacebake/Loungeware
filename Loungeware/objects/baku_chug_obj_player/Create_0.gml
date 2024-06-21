
// Background
bg_x		= 0;
bg_y		= 0;
bg_spd_x	= 0.25;
bg_spd_y	= 0.125;

// Chugging
chug_value	= 0;
chug_goal	= 85 + (DIFFICULTY * 5);
if (CONFIG_IS_RASPI) chug_goal = 65 + (DIFFICULTY * 5);
chug_add	= 5;

// Sprite offsets and other lerped junk
gun_x_offset = 128;
pepsi_y_offset = 128;
hud_alpha = 0;

// Head tilt
dir_goal = 15;
dir_value = 0;

// Swallow animation
swallow_img = 0;
swallow_max = sprite_get_number(baku_chug_spr_profile_neck) - 1;
swallow_spd = 1;
swallowing = false;

// Game state
game_started = false;
game_countdown = 60;
game_time = game_get_speed(gamespeed_fps) * 3;
game_win = false;
game_lose = false;

// Win
gun_has_shot = false;
gun_win_dir = 0;
gun_win_x = 0;
game_win_time = 0;
game_win_shoot = 15;
game_win_flash = 0;
win_cry_img = 0;

// Lose
gun_lose_dir = 0;
game_lose_time = 0;

// Squish and shake
shake_strength = 1;
squish_x = 1;
squish_y = 1;

// Point constructor
Point = function(_x, _y, _x2, _y2) constructor {
	x			= _x;
	y			= _y;
	x2			= _x2;
	y2			= _y2;
	point_dis	= point_distance(_x, _y, _x2, _y2);
	point_dir	= point_direction(_x, _y, _x2, _y2);
	x_new		= _x;
	y_new		= _y;
	x2_new		= _x2;
	y2_new		= _y2;
	dir_self	= 0;
	dir_cum		= 0;
	dir_new		= 0;
}

// Define points
points = [
	new Point(
		240,
		112,
		240,
		112
	),
	new Point(
		sprite_get_xoffset(baku_chug_spr_profile_shoulder_back),
		sprite_get_yoffset(baku_chug_spr_profile_shoulder_back),
		sprite_get_xoffset(baku_chug_spr_profile_neck),
		sprite_get_yoffset(baku_chug_spr_profile_neck),
	),
	new Point(
		sprite_get_xoffset(baku_chug_spr_profile_neck),
		sprite_get_yoffset(baku_chug_spr_profile_neck),
		sprite_get_xoffset(baku_chug_spr_profile_head),
		sprite_get_yoffset(baku_chug_spr_profile_head)
	),
	new Point(
		sprite_get_xoffset(baku_chug_spr_profile_head),
		sprite_get_yoffset(baku_chug_spr_profile_head),
		23,
		86
	),
	new Point(
		23,
		86,
		23,
		86+40
	),
];

// Profile parts
bodyparts = [
	{ point : 1,	spr : baku_chug_spr_profile_shoulder_back	},
	{ point : 2,	spr : baku_chug_spr_profile_neck			},
	{ point : 1,	spr : baku_chug_spr_profile_shoulder_front	},
	{ point : 3,	spr : baku_chug_spr_profile_head			},
	{ point : 4,	spr : baku_chug_spr_pepsi					},
];

// Keys stuffs
key = {
	up		: 0,
	down	: 1,
	left	: 2,
	right	: 3,
	a		: 4,
	b		: 5,
};
key_combo		= [];
key_combo[0]	= choose(key.up, key.down, key.left, key.right);
key_combo[1]	= choose(key.a, key.b);
last_key		= -1;

// Key images
key_offset_value	= 6;
key_offset			= 1;
key_img				= [];
key_img[0]			= key_combo[0];
key_img[1]			= key_combo[1] + key_offset_value;
key_img_time		= 0;
key_img_speed		= 5;
alarm[0]			= key_img_speed;