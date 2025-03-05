/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(sprite_index, image_index, x + shake_x, y + shake_y, 1, 1, 0, c_white, image_alpha);

// Draw Projectile start

if (!cooling_down and !dead)
{
	draw_sprite(noah_artillery_spr_reticle, 0, reticle_x, reticle_y);
}









