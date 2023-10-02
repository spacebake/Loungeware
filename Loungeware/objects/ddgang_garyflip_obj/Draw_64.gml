/// @description CHOOSE !! AND ASSORTED TEXT
if (ddprompt_timer > 0 && ddprompt_flash mod 2 = 0) {
	draw_set_color(c_white)
	draw_set_halign(fa_middle)
	draw_text(120, 145, ddprompt)
}

ddprompt_timer = max(ddprompt_timer - 1, 0)
if (ddprompt_timer = 0) {
	if (ddprompt_flash > 0) {
		ddprompt_flash --
		if (ddprompt_flash mod 2 = 1) { ddprompt_timer = 7 } else { ddprompt_timer = 7 }
	}
	
}