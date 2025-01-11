/// @description Init State and Timing

// ALL TIMES IN SECONDS

state_timer = 0; // when this timer passes
currently_sus = false;


// max allowable time where you can keep mashing and not get caught while teacher is in sus state

suspicion_threshold = 0.6 - DIFFICULTY * 0.05;
mashing_while_sus_stopwatch = 0;

// time spent lost (only let player view loss screen for a few seconds)
loss_timer = 0;
loss_viewtime = 3.5;

//// Todo: Make a function that randomly sets the timing array based on these params
bookend_time = 0.25; // don't trigger suspicious state for the first or last X seconds of the game
min_sus_duration = 0.75; 
max_sus_duration = 1.5;
min_gap_between_sus_states = 0.75; 
max_gap_between_sus_states = 3;
num_sus_states = 3;
/* 
if you change the above parameters, ensure that bookend_time * 2 + 
num_sus_states * (max_gapbetween_sus_states + max_sus_duration) <= the microgame's total duration
*/

timeline_pos = 0;
toggle_suspicion_times = generate_sus_timeline(); // This will contain each timestamp at which the sus state will swap
max_timeline_pos = array_length(toggle_suspicion_times);

init_x = x;
init_y = y;

set_win_sprite = false;