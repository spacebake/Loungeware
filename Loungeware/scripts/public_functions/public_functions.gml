//--------------------------------------------------------------------------------------------------------
// returns the current difficulty level
#macro DIFFICULTY ___global.difficulty_read() 

// camera / view
#macro VIEW_NUMBER 0
#macro CAMERA view_camera[VIEW_NUMBER]
#macro VIEW_W camera_get_view_width(CAMERA)
#macro VIEW_H camera_get_view_height(CAMERA)
#macro VIEW_X camera_get_view_x(CAMERA)
#macro VIEW_Y camera_get_view_y(CAMERA)

// returns the numbers of steps remaining on the timer (divide this by 60 to get seconds)
#macro TIME_REMAINING ___global.time_remaining_read()
// returns what the max timer value of your microgame, in steps (divide this by 60 to get seconds)
#macro TIME_MAX ___global.time_max_read()
// same as TIME_REMAING, but returns seconds instead of steps
#macro TIME_REMAINING_SECONDS (TIME_REMAINING / game_get_speed(gamespeed_fps))
// same as TIME_MAX, but returns seconds instead of steps
#macro TIME_MAX_SECONDS (TIME_MAX / game_get_speed(gamespeed_fps))

// returns the prompt displayed before the microgame starts (useful if your microgame has multiple prompts)
#macro PROMPT ___MG_MNGR.prompt

// returns a boolean which is true if the game is currently running in test mode (useful for debugging)
#macro TEST_MODE_ACTIVE ___global.test_mode_check()

//--------------------------------------------------------------------------------------------------------
// MICROGAME WIN
// (NOTE: you should not use this function if "default_is_fail" property is set to "false" in your 
// microgame's metadata, instead: see microgame_fail() )
// -
// Call this to signal the microgame was completed successfully
// this does not end the game, it just marks it as won so they player will recieve a point.
// consider playing a win animation for the remainder of the timer (see warioware for ideas)
//--------------------------------------------------------------------------------------------------------
function microgame_win(){
	if (!___MG_MNGR.microgame_won){
		___MG_MNGR.microgame_time_finished =  ___MG_MNGR.microgame_timer;
		___MG_MNGR.microgame_won = true;
	}
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME FAIL
// (NOTE: you should not use this function if "default_is_fail" property is set to "true" in your 
// microgame's metadata, instead: see microgame_win() )
// this does not end the game, it just marks it as failed so the player will lose a life.
// consider playing a fail animation for the remainder of the timer (see warioware for ideas)
//--------------------------------------------------------------------------------------------------------
function microgame_fail(){
	if (___MG_MNGR.microgame_won){
		___MG_MNGR.microgame_time_finished =  ___MG_MNGR.microgame_timer_max;
		___MG_MNGR.microgame_won = false;
	}
}

//--------------------------------------------------------------------------------------------------------
// SET TIMER MAX
// sets the microgame timer to the given value
/* if for some reason you need to set your games time limit after the game starts 
like for example if you wannted a shorter timer for increasing difficulty level,
you can use this function to set the timer. You should only use this function right as your game starts
to make sure the timer change isn't visible to the player*/
// do not use this to alter the timer during gameplay

/// @function                              microgame_set_timer_max(_new_time_in_seconds);
/// @param {int}  _new_time_in_seconds     new value for timer, in seconds.
function microgame_set_timer_max(_new_time_in_seconds){
	___MG_MNGR.microgame_timer = _new_time_in_seconds * 60;
	___MG_MNGR.microgame_timer_max = _new_time_in_seconds * 60;
}

//--------------------------------------------------------------------------------------------------------
// MICROGAME END EARLY
/* You can use this function to end your game before the timer runs out natrually.
For example: if the player fails your game in the first few seconds and there are still 5 seconds left on
the clock, you can call this to prevent making the player wait out the rest of the timer.

IMPORTANT: You still need to show some kind of fail state on the screen before you call this function.
you cant just instantly end the game the instant the player fails, that would feel too abrupt. 

note: the closing-circle transition still has to play when the microgame ends, so there will be a short
period between calling this and the microgame actually ending.*/

function microgame_end_early(){
	___MG_MNGR.microgame_timer_skip = true;
}
