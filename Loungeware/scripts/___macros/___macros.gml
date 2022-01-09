#macro WINDOW_BASE_SIZE ___global.window_base_size_read()


// html rectangle fix
#macro ___draw_rectangle_real draw_rectangle
function ___drhtmlf(x1, y1, x2, y2, outline, c = draw_get_colour(), a = draw_get_alpha()){
	if (HTML_MODE){
		x2 += 1;
		y2 += 1;
	}
	//___draw_rectangle_real(x1, y1, x2, y2, outline);
	draw_sprite_ext(___spr_pixel, 0, x1, y1, x2 - x1 - 1, y2 - y1 - 1, 0, c, a)
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
#macro c_keyred ___global.macro_c_keyred
#macro ___cart_primary_col_default ___global.macro_c_cart_primary
#macro ___cart_secondary_col_default ___global.macro_c_cart_secondary
#macro ___cart_label_default johndoe_examplegame_spr_label
#macro ___DEV_CONFIG_PATH "devconfig.lw"

#macro ___KEY_PAUSE ___macro_any_check("pause")
#macro ___KEY_PAUSE_PRESSED ___macro_any_check_pressed("pause")
#macro ___KEY_PAUSE_RELEASED ___macro_any_check_released("pause")

//the diff. between this and the public macros is these only check the specific type of device.
#macro ___KEYBOARD_PRIMARY ___keyboard_check("primary")
#macro ___KEYBOARD_PRIMARY_PRESSED ___keyboard_check_pressed("primary")
#macro ___KEYBOARD_PRIMARY_RELEASED ___keyboard_check_released("primary")

#macro ___KEYBOARD_SECONDARY ___keyboard_check("secondary")
#macro ___KEYBOARD_SECONDARY_PRESSED ___keyboard_check_pressed("secondary")
#macro ___KEYBOARD_SECONDARY_RELEASED ___keyboard_check_released("secondary")

#macro ___KEYBOARD_RIGHT ___keyboard_check("right")
#macro ___KEYBOARD_RIGHT_PRESSED ___keyboard_check_pressed("right")
#macro ___KEYBOARD_RIGHT_RELEASED ___keyboard_check_released("right")

#macro ___KEYBOARD_UP ___keyboard_check("up")
#macro ___KEYBOARD_UP_PRESSED ___keyboard_check_pressed("up")
#macro ___KEYBOARD_UP_RELEASED ___keyboard_check_released("up")

#macro ___KEYBOARD_LEFT ___keyboard_check("left")
#macro ___KEYBOARD_LEFT_PRESSED ___keyboard_check_pressed("left")
#macro ___KEYBOARD_LEFT_RELEASED ___keyboard_check_released("left")

#macro ___KEYBOARD_DOWN ___keyboard_check("down")
#macro ___KEYBOARD_DOWN_PRESSED ___keyboard_check_pressed("down")
#macro ___KEYBOARD_DOWN_RELEASED ___keyboard_check_released("down")

#macro ___KEYBOARD_PAUSE ___keyboard_check("pause")
#macro ___KEYBOARD_PAUSE_PRESSED ___keyboard_check_pressed("pause")
#macro ___KEYBOARD_PAUSE_RELEASED ___keyboard_check_released("pause")

//#macro ___KEYBOARD_CHECK_ANY


#macro ___API_BASE_URL "https://loungeware.games/game/api/"

// config specific
#macro Shipping:show_debug_overlay ___noop
// #macro RasPi:show_debug_overlay ___noop

#macro CONFIG_IS_SHIPPING false
#macro Shipping:CONFIG_IS_SHIPPING true

#macro CONFIG_IS_RASPI false
#macro RasPi:CONFIG_IS_RASPI true

#macro HTML_MODE (!(os_browser == browser_not_a_browser))
#macro DEVELOPER_MODE (___global.developer_mode_active)



