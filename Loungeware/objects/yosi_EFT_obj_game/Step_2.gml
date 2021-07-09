var _zoom = 1 - (screen_x / 10);
camera_set_view_size(CAMERA, 240 * _zoom, 160 * _zoom);
var _w = camera_get_view_width(CAMERA) div 2;
var _h = camera_get_view_height(CAMERA) div 2;
camera_set_view_pos(CAMERA, yosi_EFT_obj_firetruck.x - _w + irandom_range(-screen_x, screen_x), yosi_EFT_obj_firetruck.player_y - _h + irandom_range(-screen_y, screen_y));

screen_x = lerp(screen_x, 0, 0.1);
screen_y = lerp(screen_y, 0, 0.1);

if (yosi_EFT_obj_building.fire)
	{
	building_hp--;
	if (building_hp <= 0)
		{
		microgame_fail();
		}
	}