//--------------------------------------------------------------------------------------------------------
// CHECK INPUTS
//--------------------------------------------------------------------------------------------------------
// by default the controls are WASD or arrows to move. Z/X or K/L for primary/secondary buttons.
// here's an example of how you might use these macros: ```if (KEY_PRIMARY) shoot_bullet();```

// key primary (A button)
#macro KEY_PRIMARY ___macro_keyboard_check("primary")
#macro KEY_PRIMARY_PRESSED ___macro_keyboard_check_pressed("primary")
#macro KEY_PRIMARY_RELEASED ___macro_keyboard_check_released("primary")

// key secondary (B button)
#macro KEY_SECONDARY ___macro_keyboard_check("secondary")
#macro KEY_SECONDARY_PRESSED ___macro_keyboard_check_pressed("secondary")
#macro KEY_SECONDARY_RELEASED ___macro_keyboard_check_released("secondary")


// key right
#macro KEY_RIGHT ___macro_keyboard_check("right")
#macro KEY_RIGHT_PRESSED ___macro_keyboard_check_pressed("right")
#macro KEY_RIGHT_RELEASED ___macro_keyboard_check_released("right")

// key up
#macro KEY_UP ___macro_keyboard_check("up")
#macro KEY_UP_PRESSED ___macro_keyboard_check_pressed("up")
#macro KEY_UP_RELEASED ___macro_keyboard_check_released("up")

// key left
#macro KEY_LEFT ___macro_keyboard_check("left")
#macro KEY_LEFT_PRESSED ___macro_keyboard_check_pressed("left")
#macro KEY_LEFT_RELEASED ___macro_keyboard_check_released("left")

// key down
#macro KEY_DOWN ___macro_keyboard_check("down")
#macro KEY_DOWN_PRESSED ___macro_keyboard_check_pressed("down")
#macro KEY_DOWN_RELEASED ___macro_keyboard_check_released("down")


// key any
#macro KEY_ANY (KEY_PRIMARY || KEY_SECONDARY || KEY_RIGHT || KEY_UP || KEY_LEFT || KEY_DOWN)
#macro KEY_ANY_PRESSED (KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED || KEY_RIGHT_PRESSED || KEY_UP_PRESSED || KEY_LEFT_PRESSED || KEY_DOWN_PRESSED)
#macro KEY_ANY_RELEASED (KEY_PRIMARY_RELEASED || KEY_SECONDARY_RELEASED || KEY_RIGHT_RELEASED || KEY_UP_RELEASED || KEY_LEFT_RELEASED || KEY_DOWN_RELEASED)