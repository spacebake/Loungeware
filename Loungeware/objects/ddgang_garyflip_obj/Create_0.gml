/// @description INITIALIZE NORRIS FLIP
input_arr = array_create(2)
input_button_time = array_create(2)
min_offs = 100
win_timer = 90
//DDPrompt
ddprompt = "choose"
ddprompt_timer = 15
ddprompt_flash = 2
//Gary data
norrispos = array_create(2, -1)
count = 2 + DIFFICULTY
norrisy = 55
//define reroll function
reroll = function() {
	norrispos[0] = irandom(1)
	norrispos[1] = !norrispos[0]
}
//Code
reroll()
microgame_music_start(sng_zandy_xylo, 1, false)
//LEMME DO THE COMMIT
//i swear to god why does the thing not realize there is change, you want change ? here's change