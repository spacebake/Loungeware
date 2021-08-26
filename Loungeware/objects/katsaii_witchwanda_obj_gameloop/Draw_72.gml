/// @desc Draw island.
var angle = current_time * 0.1;
var dx = lengthdir_x(2, angle);
var dy = lengthdir_y(2, angle);
var xpos = floor(lerp(KATSAII_WITCH_WANDA_VIEW_RIGHT + 200, KATSAII_WITCH_WANDA_VIEW_CENTRE_X + dx, katsaii_witchwanda_easein(fadeIn)));
var ypos = floor(lerp(KATSAII_WITCH_WANDA_VIEW_CENTRE_Y + dy, KATSAII_WITCH_WANDA_VIEW_BOTTOM + 200, katsaii_witchwanda_easein(fadeOut)));
var tilt = 0;
if (global.jamHp < 10) {
    var range = (10 - global.jamHp) / 3;
    tilt = -10 * range;
    ypos += 10 * range;
    xpos += random_range(-range, range);
    ypos += random_range(-range, range);
}
draw_sprite_ext(katsaii_witchwanda_spr_main_island, 0, xpos, ypos, 1, 1, tilt, c_white, 1);
draw_set_alpha(0.9);
draw_circle_colour(xpos, ypos, global.jamHp + 0.5 * dsin(angle), JamCBlue.DEEP_SKY, JamCYellow.REKINDLED, false);
draw_circle_colour(xpos, ypos, global.jamHp + 2 + 0.5 * dsin(angle), JamCBlue.DEEP_SKY, JamCYellow.REKINDLED, true);
draw_set_alpha(max(0, sin(current_time * 0.001)));
draw_set_font(katsaii_witchwanda_fnt_default);
draw_set_colour(JAM_COLOUR_BLEND);
gpu_set_blendmode(bm_add);
katsaii_witchwanda_draw_text_wonky(xpos, ypos + 30, "HEALTH");
gpu_set_blendmode(bm_normal);
draw_set_alpha(1);
// GUI
draw_set_font(katsaii_witchwanda_fnt_tiny);
draw_set_color(JAM_COLOUR_BLEND);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
var linear = min(fadeOut * max(gameRestartTimer, 0), 1);
var interp = katsaii_witchwanda_easein(linear);
draw_set_alpha(max(gameRestartTimer, 0));
//katsaii_witchwanda_draw_text_wonky(KATSAII_WITCH_WANDA_VIEW_CENTRE_X, lerp(KATSAII_WITCH_WANDA_VIEW_TOP + 10, KATSAII_WITCH_WANDA_VIEW_CENTRE_Y - 10, interp), "Score: " + string(global.jamScore) + " (High: " + string(global.jamHighScore) + ")");
draw_set_alpha(1.0);
if not (surface_exists(gameOverSurface)) {
    gameOverSurface = surface_create(KATSAII_WITCH_WANDA_VIEW_WIDTH, KATSAII_WITCH_WANDA_VIEW_HEIGHT);
}
surface_set_target(gameOverSurface);
draw_clear_alpha(c_black, 0);
if (interp > 0) {
    draw_set_font(katsaii_witchwanda_fnt_script);
    katsaii_witchwanda_draw_text_3d(lerp(KATSAII_WITCH_WANDA_VIEW_LEFT - 200, KATSAII_WITCH_WANDA_VIEW_CENTRE_X - 50, interp), KATSAII_WITCH_WANDA_VIEW_CENTRE_Y - 20, "Game", 10, JamCRed.FORREST_FIRE, c_white);
    katsaii_witchwanda_draw_text_3d(lerp(KATSAII_WITCH_WANDA_VIEW_RIGHT + 200, KATSAII_WITCH_WANDA_VIEW_CENTRE_X + 50, interp), KATSAII_WITCH_WANDA_VIEW_CENTRE_Y - 20, "Over", 10, JamCRed.FORREST_FIRE, c_white);
}
if (fadeIn > 0.01 && fadeIn < 0.99) {
    draw_set_font(katsaii_witchwanda_fnt_tiny);
    katsaii_witchwanda_draw_text_3d(
            lerp(KATSAII_WITCH_WANDA_VIEW_RIGHT + 200, KATSAII_WITCH_WANDA_VIEW_LEFT - 200, katsaii_witchwanda_midslow(fadeIn)),
            KATSAII_WITCH_WANDA_VIEW_BOTTOM - 70,
            "Protect the Island",
            5, JamCPink.WILD_STRAWBERRY, JamCYellow.REKINDLED);
}
surface_reset_target();
var tex = surface_get_texture(gameOverSurface);
katsaii_witchwanda_shader_set_effect_outline(texture_get_texel_width(tex), texture_get_texel_height(tex), JAM_COLOUR_BLEND);
draw_surface(gameOverSurface, KATSAII_WITCH_WANDA_VIEW_LEFT, KATSAII_WITCH_WANDA_VIEW_TOP);
shader_reset();
var band_mid = KATSAII_WITCH_WANDA_VIEW_BOTTOM - 20;
var band_top = band_mid - 6;
var band_bottom = band_mid + 4;
var difficulties = difficultyLevels;
var difficulty_limit = array_length(difficulties);
var scale = 35;
var centre_x = KATSAII_WITCH_WANDA_VIEW_CENTRE_X;
draw_set_valign(fa_middle);
draw_set_font(katsaii_witchwanda_fnt_default);
draw_set_colour(c_white);
draw_line(centre_x, band_top - 4, centre_x, band_bottom + 3);
//draw_line(KATSAII_WITCH_WANDA_VIEW_LEFT, band_top - 1, KATSAII_WITCH_WANDA_VIEW_RIGHT, band_top - 1);
//draw_line(KATSAII_WITCH_WANDA_VIEW_LEFT, band_bottom + 1, KATSAII_WITCH_WANDA_VIEW_RIGHT, band_bottom + 1);
var start_x = KATSAII_WITCH_WANDA_VIEW_LEFT;
for (var i = -4; i <= difficulty_limit; i += 4) {
    var end_x, colour, colour2, caption;
    if (i == -4) {
        // ...
        end_x = centre_x - global.jamDifficulty * scale;
        colour = c_dkgrey;
        colour2 = c_white;
        caption = "";
    } else if (i == difficulty_limit) {
        // ???
        end_x = KATSAII_WITCH_WANDA_VIEW_RIGHT + 100;
        colour = c_black;
        colour2 = c_white;
        caption = "WTF";
    } else {
        end_x = start_x + difficulties[i + 0] * scale;
        colour = difficulties[i + 1];
        colour2 = difficulties[i + 3];
        caption = difficulties[i + 2];
    }
    if (end_x > KATSAII_WITCH_WANDA_VIEW_LEFT && start_x < KATSAII_WITCH_WANDA_VIEW_RIGHT) {
        var caption_width = string_width(caption) + 10;
        var caption_x = clamp(centre_x, start_x + caption_width / 2, end_x - caption_width / 2);
        draw_set_colour(colour);
        draw_rectangle(start_x, band_top, end_x, band_bottom, false);
        draw_set_colour(colour2);
        draw_text(caption_x, band_mid, caption);
    }
    start_x = end_x;
}
draw_set_colour(c_white);
gpu_set_blendmode(bm_add);
var width = sprite_get_width(katsaii_witchwanda_spr_sheen);
var left = KATSAII_WITCH_WANDA_VIEW_LEFT - width;
var right = KATSAII_WITCH_WANDA_VIEW_RIGHT + width;
for (var i = left; i < right; i += width) {
    var offset = floor(current_time * 0.02) % width;
    draw_sprite(katsaii_witchwanda_spr_sheen, 0, i + offset, band_top);
}
gpu_set_blendmode(bm_normal);