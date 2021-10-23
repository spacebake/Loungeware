#macro WINDOW_BASE_SIZE ___global.window_base_size_read()


// html rectangle fix
#macro ___draw_rectangle_real draw_rectangle
function ___drhtmlf(x1, y1, x2, y2, outline){
	if (HTML_MODE){
		x2 += 1;
		y2 += 1;
	}
	___draw_rectangle_real(x1, y1, x2, y2, outline);
}
#macro draw_rectangle ___drhtmlf


#macro c_magenta ___global.macro_c_magenta
#macro c_gbyellow ___global.macro_c_gbyellow
#macro c_gbpink  ___global.macro_c_gbpink
#macro c_gbblack ___global.macro_c_gbblack
#macro c_gboff ___global.macro_c_gboff
#macro c_gbbacklight ___global.macro_c_gbacklight
#macro c_gbtimer_full ___global.macro_c_gbtimer_full
#macro c_gbtimer_empty ___global.macro_c_gbtimer_empty
#macro c_gbwhite ___global.macro_c_gbwhite
#macro c_gbdark ___global.macro_c_gbdark
#macro c_larold ___global.macro_c_larold
#macro ___cart_primary_col_default ___global.macro_c_cart_primary
#macro ___cart_secondary_col_default ___global.macro_c_cart_secondary
#macro ___cart_label_default johndoe_examplegame_spr_label
#macro ___DEV_CONFIG_PATH "devconfig.lw"

#macro ___KEY_PAUSE ___macro_keyboard_check("pause")
#macro ___KEY_PAUSE_PRESSED ___macro_keyboard_check_pressed("pause")
#macro ___KEY_PAUSE_RELEASED ___macro_keyboard_check_released("pause")

#macro ___API_BASE_URL "https://loungeware.games/game/api/"

// config specific
#macro Shipping:show_debug_overlay ___noop

#macro CONFIG_IS_SHIPPING false
#macro Shipping:CONFIG_IS_SHIPPING true

#macro HTML_MODE (!(os_browser == browser_not_a_browser))
#macro DEVELOPER_MODE (___global.developer_mode_active)



