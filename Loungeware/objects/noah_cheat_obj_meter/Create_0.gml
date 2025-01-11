/// @description Init Meter and Mashing Tracking

input_count = 0; // how many button presses have been made
meter_fill = 0; // ranges from 0 to 1
max_fill_width = sprite_get_width(noah_cheat_spr_meter_scribble);
fill_bar_height = sprite_get_height(noah_cheat_spr_meter_scribble);
var _difficultyIncrement = 4;
input_goal = 15 + (DIFFICULTY - 1) * _difficultyIncrement; 
mashing_duration = 0; // track how long the player has been mashing
mashing_cooldown = 0.2; // the time in seconds that must elapse with no input to exit the mashing state
mashing_cooldown_timer = 0;
currently_mashing = false; // whether the player is mashing

game_active = true; // simple game state manager
game_result_win = false; // outcome of game

init_x = x;
init_y = y;