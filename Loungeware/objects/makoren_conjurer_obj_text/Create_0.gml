first_words = ["sword", "potion", "hammer", "bow"];
second_words = ["righteous", "explosive", "offensive", "thirsty", "dull", "ancient", "dapper", "royal"];
third_words = ["banning", "lounging", "disease", "energy", "vibes", "garbage"];

// indices of the text you need to copy
var _first_index = irandom(array_length(first_words) - 1);
var _second_index = irandom(array_length(second_words) - 1);
var _third_index = irandom(array_length(third_words) - 1);

// the text you need to copy
var _first_word = string(first_words[_first_index]);
var _second_word = string(second_words[_second_index]);
var _third_word = string(third_words[_third_index]);
target_text_label = _first_word + " of " + _second_word + " " + _third_word;
target_text = [_first_word, _second_word, _third_word];

generate_index = function(arr, i) {
	var _matching = true;
	var _index = 0;
	while (_matching) {
		_index = irandom(array_length(arr) - 1)
		_matching = (_index == i) ? true : false;
	}
	return _index;
}

// the text you control
selected_indices = [
	generate_index(first_words, _first_index),
	generate_index(second_words, _second_index),
	generate_index(third_words, _third_index)
];

selected_text = [first_words[selected_indices[0]], second_words[selected_indices[1]], third_words[selected_indices[2]]];
selected_section = [first_words, second_words, third_words];
selected_section_index = 0;

// arrow animation
arrow_scale = 1;

// delay the text for a bit so players can see the prompt
appear_delay = 0.8;

inputs_disabled = false;
should_draw = true;

win = function() {
	microgame_win();
	inputs_disabled = true;
	should_draw = false;
	
	makoren_conjurer_obj_item.visible = true;
	makoren_conjurer_obj_light.visible = true;
	makoren_conjurer_obj_item.image_index = selected_indices[0];
	makoren_conjurer_obj_larold.sprite_index = makoren_conjurer_spr_larold_win;
	
	sfx_play(makoren_conjurer_snd_powerup, 1, false);
}

lose = function() {
	inputs_disabled = true;
	should_draw = false;
	
	sfx_play(makoren_conjurer_snd_lose, 1, false);
	
	makoren_conjurer_obj_larold.sprite_index = makoren_conjurer_spr_larold_lose;
	
	instance_create_layer(makoren_conjurer_obj_item.x, makoren_conjurer_obj_item.y, "Instances", makoren_conjurer_obj_particles);
}

check_if_won = function() {
	// increments each time it finds a correct row
	var _amount_correct = 0;
	for (var i = 0; i < 3; i++) {
		if (selected_text[i] == target_text[i])
			_amount_correct++;
	}
	
	return _amount_correct >= 3;
}