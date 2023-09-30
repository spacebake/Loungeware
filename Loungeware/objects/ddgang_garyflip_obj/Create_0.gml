/// @description INITIALIZE NORRIS FLIP
norrispos = array_create(2, -1)
count = 2 + DIFFICULTY
input_arr = array_create(2)
input_button_time = array_create(2)
min_offs = 100
//define reroll function
reroll = function() {
	norrispos[0] = irandom(1)
	norrispos[1] = !norrispos[0]
}
//Code
reroll()
microgame_music_start(sng_zandy_xylo, 1, false)