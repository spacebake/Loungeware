/// @desc Draw player.
var z = fallTimer < 0.5 ? 0 : lerp(0, room_height, (fallTimer - 0.5) * (fallTimer - 0.5) * 4);
draw_sprite_ext(katsaii_witchsplore_wanda, image_index + (flipY ? 4 : 0), 0, z, flipX ? -1 : 1, 1, 0, c_white, 1);