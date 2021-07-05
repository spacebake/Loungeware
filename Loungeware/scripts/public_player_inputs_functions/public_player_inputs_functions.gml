//--------------------------------------------------------------------------------------------------------
// CHECK INPUTS
//--------------------------------------------------------------------------------------------------------
// by default the controls are WASD or arrows to move. Z/X or K/L for primary/secondary buttons.
// here's an example of how you might use these macros: ```if (KEY_PRIMARY) shoot_bullet();```

// check keys held
#macro KEY_RIGHT ___macro_keyboard_check("right")
#macro KEY_UP ___macro_keyboard_check("up")
#macro KEY_LEFT ___macro_keyboard_check("left")
#macro KEY_DOWN ___macro_keyboard_check("down")
#macro KEY_PRIMARY ___macro_keyboard_check("primary")
#macro KEY_SECONDARY ___macro_keyboard_check("secondary")
#macro KEY_PAUSE ___macro_keyboard_check("pause")

//check keys pressed
#macro KEY_RIGHT_PRESSED ___macro_keyboard_check_pressed("right")
#macro KEY_UP_PRESSED ___macro_keyboard_check_pressed("up")
#macro KEY_LEFT_PRESSED ___macro_keyboard_check_pressed("left")
#macro KEY_DOWN_PRESSED ___macro_keyboard_check_pressed("down")
#macro KEY_PRIMARY_PRESSED ___macro_keyboard_check_pressed("primary")
#macro KEY_SECONDARY_PRESSED ___macro_keyboard_check_pressed("secondary")
#macro KEY_PAUSE_PRESSED ___macro_keyboard_check_pressed("pause")

//check keys released
#macro KEY_RIGHT_RELEASED ___macro_keyboard_check_released("right")
#macro KEY_UP_RELEASED ___macro_keyboard_check_released("up")
#macro KEY_LEFT_RELEASED ___macro_keyboard_check_released("left")
#macro KEY_DOWN_RELEASED ___macro_keyboard_check_released("down")
#macro KEY_PRIMARY_RELEASED ___macro_keyboard_check_released("primary")
#macro KEY_SECONDARY_RELEASED ___macro_keyboard_check_released("secondary")
#macro KEY_PAUSE_RELEASED ___macro_keyboard_check_released("pause")
