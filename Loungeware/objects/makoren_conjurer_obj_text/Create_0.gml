font = font_add("makoren_conjurer_font.ttf", 6, false, false, 32, 128);

first_words = ["sword", "potion", "hammer", "lounge", "bow"];
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

inputs_disabled = false;

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
		// win animation
	}
}
