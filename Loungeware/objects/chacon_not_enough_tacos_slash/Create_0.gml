/// @description
randomize();

depth = -10000;

// Set slash sprite
sprite_index = choose(chacon_not_enough_tacos_sprite_slash, chacon_not_enough_tacos_sprite_slash_2);

// Add variation by flipping sprite
scale = choose(1, -1);

image_xscale = scale;
image_yscale = scale;