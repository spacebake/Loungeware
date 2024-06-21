/// @description DRAW GAME CONTENTS
//Lerp gary back in
norrisy = lerp(norrisy, 55, 0.5)
//Left side
draw_sprite(ddgang_garyflip_garysprt, norrispos[0], -5, norrisy)
draw_sprite(spr_button_b, min(input_button_time[0], 1), 43, 5)
//Right side
draw_sprite(ddgang_garyflip_garysprt, norrispos[1], 127, norrisy)
draw_sprite(spr_button_a, min(input_button_time[1], 1), 182, 5)