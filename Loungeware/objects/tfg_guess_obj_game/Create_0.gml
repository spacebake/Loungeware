#macro TFG_GUESS_CURR_PROMPT tfg_guess_obj_game.prompt
#macro TFG_GUESS_MILE_SCALE (24812 / room_width)

selected = false;
won = false;
made_a_larl = false;

var prompts = [];
with (tfg_guess_obj_country) {
	array_push(prompts, id);	
}
prompt = prompts[irandom(array_length(prompts) - 1)];

