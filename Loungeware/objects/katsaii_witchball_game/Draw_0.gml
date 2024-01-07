// background
var sunsetTimer = timer * 0.01;
draw_sprite(katsaii_witchball_bg_sky, theme, 0, 0);
draw_sprite(katsaii_witchball_bg_sun, theme, theme * 20 + round(sunsetTimer / 3), round(sunsetTimer));
draw_sprite(katsaii_witchball_bg_clouds, theme, 0, 0);
draw_sprite(katsaii_witchball_bg_surface, theme, 0, 0);

// larl
var ballOffset = max(timer - 50, 0);
draw_sprite_ext(katsaii_witchball_larl, larlState, 120, 100, larlDirection, 1, 0, c_white, 1);
draw_sprite_ext(katsaii_witchball_ball, ball, 120 + ballOffset * larlDirection * 0.5, 100 - 50 - ballOffset * 3, 0.5, 0.5, ballOffset * 5, c_white, 1);

// midground
draw_sprite(katsaii_witchball_net, 0, 0, 0);
if (hasAntony) {
    draw_sprite(katsaii_witchball_antony, 0, 0, 0);
}

// ball
var ballX = room_width / 2 + larlDirection * 60;
var ballY = lerp(-50, room_height - 35, clamp(ballPosition, 0, 1));
draw_circle_colour(ballX - 1, ballY - 1, 16, c_white, c_white, false);
draw_sprite_ext(katsaii_witchball_ball, ball, ballX, ballY, 1, 1, ballY * 5, c_white, 1);

// wanda
if (wandaState == 0) {
    draw_sprite_ext(katsaii_witchball_wanda_head, wanda == 3, room_width / 2, room_height, wandaDirection, 1, 0, c_white, 1);
} else {
    var spr = wandaState == 1 ? katsaii_witchball_wanda_dive : katsaii_witchball_wanda_fail;
    var shake = wandaState == 1 ? round(timer / 8 % 2) * wandaDirection : 0;
    draw_sprite_ext(spr, wanda, room_width / 2 + shake, room_height, wandaDirection, 1, 0, c_white, 1);
}

// foreground
if (hasMimpNet) {
    draw_sprite(katsaii_witchball_mimpnet, round(timer / 30) % 2, 0, 0);
}
if (hasLilGhost) {
    draw_sprite(katsaii_witchball_lilghost, 0, 0, round(dsin(timer * 2)));
}