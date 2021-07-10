first_words = ["sword", "potion", "hammer", "bow"];
second_words = ["righteous", "explosive", "offensive", "bad", "good"];
third_words = ["banning", "lounging", "fun", "sadness", "vibes"];

// the text you need to copy
var _first_word = string(first_words[irandom(array_length(first_words) - 1)]);
var _second_word = string(second_words[irandom(array_length(second_words) - 1)]);
var _third_word = string(third_words[irandom(array_length(third_words) - 1)]);
target_text_label = _first_word + " of " + _second_word + " " + _third_word;
target_text = [_first_word, _second_word, _third_word];

// the text you control
selected_indices = [0, 0, 0];
selected_text = [first_words[selected_indices[0]], second_words[selected_indices[1]], third_words[selected_indices[2]]];
selected_section = [first_words, second_words, third_words];
selected_section_index = 0;

// arrow animation
arrow_scale = 1;

// screen flash
screenflash_alpha = 0;

// delay the text for a bit so players can see the prompt
appear_delay = 0.8;

inputs_disabled = false;
should_draw = true;

check_if_won = function()
{
	var _amount_correct = 0;
	for (var i = 0; i < 3; i++)
	{
		if (selected_text[i] == target_text[i])
			_amount_correct++;
	}
	
	if (_amount_correct >= 3)
	{
		microgame_win();
		inputs_disabled = true;
		should_draw = false;
		screenflash_alpha = 1;
		
		makoren_conjurer_obj_item.visible = true;
		makoren_conjurer_obj_item.image_index = selected_indices[0]
		
		audio_play_sound(makoren_conjurer_snd_powerup, 100, false);
		
		var bg_layer = layer_get_id("Background");
		var bg_id = layer_background_get_id(bg_layer);
		layer_background_sprite(bg_id, makoren_conjurer_spr_bg_win);
	}
}
