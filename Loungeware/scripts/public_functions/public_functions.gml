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
	if (!___GM.microgame_won){
		___GM.microgame_time_finished =  ___GM.microgame_timer;
		___GM.microgame_won = true;
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
	if (___GM.microgame_won){
		___GM.microgame_time_finished =  ___GM.microgame_timer_max;
		___GM.microgame_won = false;
	}
}

//--------------------------------------------------------------------------------------------------------
// returns the current difficulty level
#macro DIFFICULTY ___global.difficulty_read() 
// camera / view
#macro CAMERA view_camera[0]
#macro VIEW_W camera_get_view_width(CAMERA)
#macro VIEW_H camera_get_view_height(CAMERA)
#macro VIEW_X camera_get_view_x(CAMERA)
#macro VIEW_y camera_get_view_y(CAMERA)
// returns the numbers of steps remaining on the timer (divide this by 60 to get seconds)
#macro TIME_REMAINING ___global.time_remaining_read()
// returns what the max timer value of your microgame, in steps (divide this by 60 to get seconds)
#macro TIME_START ___global.time_max_read()





