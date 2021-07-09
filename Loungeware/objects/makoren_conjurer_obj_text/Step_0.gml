if (KEY_DOWN_PRESSED and !inputs_disabled)
{
	if (selected_section_index + 1 <= 2)
		selected_section_index++;
	else
		selected_section_index = 0;
}

if (KEY_UP_PRESSED and !inputs_disabled)
{
	if (selected_section_index - 1 >= 0)
		selected_section_index--;
	else
		selected_section_index = array_length(selected_section) - 1;
}

if (KEY_RIGHT_PRESSED and !inputs_disabled)
{
	if (selected_indices[selected_section_index] + 1 <= array_length(selected_section[selected_section_index]) - 1)
		selected_indices[selected_section_index]++;
	else
		selected_indices[selected_section_index] = 0;
		
	selected_text = [first_words[selected_indices[0]], second_words[selected_indices[1]], third_words[selected_indices[2]]];
	check_if_won();
}


if (KEY_LEFT_PRESSED and !inputs_disabled)
{
	if (selected_indices[selected_section_index] - 1 >= 0)
		selected_indices[selected_section_index]--;
	else
		selected_indices[selected_section_index] = array_length(selected_section[selected_section_index]) - 1;
	
	selected_text = [first_words[selected_indices[0]], second_words[selected_indices[1]], third_words[selected_indices[2]]];
	check_if_won();
}

arrow_scale = 0.05 * sin(0.01 * current_time) + 1;