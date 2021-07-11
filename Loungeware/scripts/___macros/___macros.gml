#macro WINDOW_BASE_SIZE ___global.window_base_size_read()

#macro c_magenta ___global.macro_c_magenta
#macro c_gbyellow ___global.macro_c_gbyellow
#macro c_gbpink  ___global.macro_c_gbpink
#macro c_gbblack ___global.macro_c_gbblack
#macro c_gboff ___global.macro_c_gboff
#macro c_gbbacklight ___global.macro_c_gbacklight
#macro c_gbtimer_full ___global.macro_c_gbtimer_full
#macro c_gbtimer_empty ___global.macro_c_gbtimer_empty
#macro c_gbwhite ___global.macro_c_gbwhite
#macro ___cart_primary_col_default ___global.macro_c_cart_primary
#macro ___cart_secondary_col_default ___global.macro_c_cart_secondary
#macro ___cart_label_default johndoe_examplegame_spr_label

#macro ___KEY_PAUSE ___macro_keyboard_check("pause")
#macro ___KEY_PAUSE_PRESSED ___macro_keyboard_check_pressed("pause")
#macro ___KEY_PAUSE_RELEASED ___macro_keyboard_check_released("pause")

#macro SET_TEST_VARS ___global.test_vars = 

#macro SHIPPING:show_debug_overlay ___noop