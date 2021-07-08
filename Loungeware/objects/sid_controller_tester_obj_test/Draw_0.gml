/// @description 
var _str = "";

_str += "UP: " + string(KEY_UP_PRESSED);
_str += "|" + string(KEY_UP) + "|" + string(KEY_UP_RELEASED) + "\n";
_str += "DOWN: " + string(KEY_DOWN_PRESSED);
_str += "|" + string(KEY_DOWN) + "|" + string(KEY_DOWN_RELEASED) + "\n";
_str += "LEFT: " + string(KEY_LEFT_PRESSED);
_str += "|" + string(KEY_LEFT) + "|" + string(KEY_LEFT_RELEASED) + "\n";
_str += "RIGHT: " + string(KEY_RIGHT_PRESSED);
_str += "|" + string(KEY_RIGHT) + "|" + string(KEY_RIGHT_RELEASED) + "\n";
_str += "PRIMARY: " + string(KEY_PRIMARY_PRESSED);
_str += "| " + string(KEY_PRIMARY) + "|" + string(KEY_PRIMARY_RELEASED) + "\n";
_str += "SECONDARY: " + string(KEY_SECONDARY_PRESSED);
_str += "| " + string(KEY_SECONDARY) + "|" + string(KEY_SECONDARY_RELEASED) + "\n";
draw_text(0,0,_str);
