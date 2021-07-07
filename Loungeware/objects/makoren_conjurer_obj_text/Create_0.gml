font = font_add("makoren_conjurer_font.ttf", 6, false, false, 32, 128);

first_words = ["sword", "potion", "hammer", "lounge", "bow"];
second_words = ["righteous", "normal", "offensive", "bad", "good"];
third_words = ["banning", "lounging", "fun", "sadness", "vibes"];

// the text you need to copy
var _first_word = string(first_words[irandom(array_length(first_words) - 1)]);
var _second_word = string(second_words[irandom(array_length(second_words) - 1)]);
var _third_word = string(third_words[irandom(array_length(third_words) - 1)]);
target_text = _first_word + " of " + _second_word + " " + _third_word;

// the text you control
initial_text = [first_words[0], second_words[0], third_words[0]];
