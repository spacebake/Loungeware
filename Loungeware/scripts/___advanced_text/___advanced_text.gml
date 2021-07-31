function ___init_advanced_text(){
/*

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 TAG EXAMPLES:
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
--------------------------------------------------------------------------
<col, R, G, B>                | begins drawing specified RGB color
</col>                        | resets color back to draw col
--------------------------------------------------------------------------
<shake>                       | shakes individual letters 
<shake, shake_val>            | shakes individual letters but with a specified shakiness (shake_val) default is 0.5
</shake>                      | stops shaking after this point
--------------------------------------------------------------------------
<wave, wave_rad>              | makes letters wave
</wave>                       | stops waving after this point
--------------------------------------------------------------------------
*/

___global.debug_messages_on = false;

function ___alert(_txt){
	if (___global.debug_messages_on) show_message(string(_txt));
}

___global._DTA_WAVE_DIR = 0;
___global._DTA_WAVE_SPEED = 8;
___global._DTA_FONT_Y_OFFSET_MAP = ds_map_create();
___global._DTA_FONT_Y_OFFSET_MAP[? fnt_frogtype] = 0;
___global._DTA_SCALE = 1;

// -------------------------------------------------------------------------------------
// DRAW TEXT ADVANCED
// -------------------------------------------------------------------------------------
function ___draw_text_advanced(x, y, line_height, is_alive, string_complete, str, _OPT_aliveshakeval, _OPT_scale, _OPT_letter_spacing){
	if (0) return argument[0];
	
	// fix broken end tag on string
	str = ___DTA_fix_end_tag(str);
	
	// remove pause tags
	str = string_replace_all(str, "£", "");
	
	var scale =___global._DTA_SCALE;
	if (!is_undefined(_OPT_scale)){
		scale = _OPT_scale;
	}

	var str_len = string_length(str);
	var insert = 0;
	var line = 0;
	if (is_undefined(_OPT_letter_spacing)) _OPT_letter_spacing = 0;
	var current_line_width = ___DTA_return_line_width(str, line, _OPT_letter_spacing) * scale;
	var letter_width = (string_width("M") + _OPT_letter_spacing)*scale;
	
	var def_draw_col = draw_get_color();
	var def_halign = draw_get_halign();
	var def_valign = draw_get_valign();
	var def_font = draw_get_font();
	var def_alpha = draw_get_alpha();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	var shake_active = false;
	var shake_val_default = 0.5;
	var shake_val = shake_val_default;
	
	
	var wave_active = false;
	var wave_rad_default = 1;
	var wave_rad = wave_rad_default;
	
	var alive_shake_val = 0.5;
	if (!is_undefined(_OPT_aliveshakeval)) alive_shake_val = _OPT_aliveshakeval;
	
	var textbox_id = (string(id) + "/" + string(x) + "/" + string(y) + ":");
	
	var hidden = false;
	
	
	
	// LOOP THROUGH EACH CHAR IN STRING ------------------------------------------------
	for (var i = 1; i < str_len+1; i++){
		
		var this_letter = string_char_at(str, i);
		var x_mod = 0;
		var y_mod = 0;
		
		// go down a line and reset insert if this char is a linebreak 
		if (this_letter == "\n") {
			line += 1;
			current_line_width = ___DTA_return_line_width(str, line, _OPT_letter_spacing) * scale;
			insert = 0;
			continue;
		}
		
		// deal with tags -----------------------
		if (this_letter == "<"){
			
			// get tag data
			var tag_start_pos = i+1;
			var tag_end_pos = tag_start_pos + 1;
			while (string_char_at(str, tag_end_pos+1) != ">"){
				tag_end_pos += 1;
				if (tag_end_pos >= string_length(str)) ___alert("ERROR IN TEXT STRING. NO CLOSING TAG \">\"FOUND");
			}
			var tag_data_as_string = string_copy(str, tag_start_pos, (tag_end_pos - tag_start_pos)+1);
			var tag_data_as_array = ___split_string_by_char(tag_data_as_string, ",", true);
			var tag_type = string_lower(tag_data_as_array[0]);
			
			// execute tag functions
			switch (tag_type) {
				
				case "col": {
					if (array_length(tag_data_as_array) != 4) ___alert("ERROR IN <COL> TAG. WRONG NUMBER OF ARGUMENTS");
					var col_rgb = make_color_rgb( real(tag_data_as_array[1]), real(tag_data_as_array[2]), real(tag_data_as_array[3]) );
					draw_set_color(col_rgb);
					break;
				}
				case "/col": { draw_set_color(def_draw_col); break;}
				case "shake": { shake_active = true; if (array_length(tag_data_as_array) > 1) shake_val = real(tag_data_as_array[1]); break;}
				case "/shake": { shake_active = false; shake_val = shake_val_default; break;}
				case "wave": {wave_active = true; if (array_length(tag_data_as_array) > 1) wave_rad = real(tag_data_as_array[1]); break;}
				case "/wave": {wave_active = false; wave_rad = wave_rad_default; break;}
				case "font":{
					if (array_length(tag_data_as_array) != 2) ___alert("ERROR IN <FONT> TAG. WRONG NUMBER OF ARGUMENTS");
					var new_font = asset_get_index(tag_data_as_array[1]);
					if (new_font == -1) ___alert("ERROR IN <FONT> TAG. NO FONT BY THIS NAME: " + string(tag_data_as_array[1]));
					draw_set_font(new_font);
					letter_width = string_width("M");
					break;
				}
				case "/font":{ draw_set_font(def_font); letter_width = string_width("M");; break;}
				case "hide":{ hidden = true; break;}
				case "/hide":{ hidden = false; break;}
				default: {___alert("INVALID TEXT TAG TYPE: \"" + tag_type + "\"") break;};	
			}
			
			i = tag_end_pos+1;
			continue;
		}
		
		
		// X/Y MODS -------------------
		
		// apply shake if active
		if (shake_active) {
			x_mod+= random_range(-shake_val, shake_val);
			y_mod+= random_range(-shake_val, shake_val);
		}
		
		// apply wave if active 
		if (wave_active) y_mod += lengthdir_y(wave_rad,___global._DTA_WAVE_DIR-(45*i));
		
		// apply alive-shake if active
		if (is_alive) && (ds_list_find_index(___global.active_char_id_list, textbox_id + string(i)) != -1){ 
			x_mod += random_range(-alive_shake_val, alive_shake_val);
			y_mod += random_range(-alive_shake_val, alive_shake_val);
		}
		
		//apply font offsets
		if (!is_undefined(___global._DTA_FONT_Y_OFFSET_MAP[? draw_get_font()])){
			y_mod +=___global._DTA_FONT_Y_OFFSET_MAP[? draw_get_font()];
		} else {
			//log("no Y offset defined for this font");
		}
		
		//apply last letter mod
		if (!string_complete) && (i == str_len) y_mod -= 1;
		
		//add this letter to potential alive letters list
		if (is_alive) && (string_complete) ds_list_add(___global.active_char_potential_letters, textbox_id + string(i));
		
		//draw the letter
		if (!hidden){
			switch (def_halign){

				case fa_left: {draw_text_transformed(((x + x_mod) + (insert)), ((y + y_mod) + (line * line_height)) , this_letter, scale, scale, 0); break};
				case fa_right: {draw_text_transformed(((x + x_mod) - current_line_width + (insert)), ((y + y_mod) + (line * line_height)), this_letter, scale, scale, 0); break};
				case fa_center: {draw_text_transformed(((x + x_mod) - ((current_line_width)/2) + (insert)), ((y + y_mod) + (line * line_height)), this_letter, scale, scale, 0); break};
			}
		}
		
		draw_set_alpha(def_alpha);
		insert += letter_width;
		
	} // --------------------------------------------------------------------------------
	
	draw_set_color(def_draw_col);
	draw_set_font(def_font);
	draw_set_valign(def_valign);
	draw_set_halign(def_halign);
	draw_set_alpha(def_alpha);
	
}


// -------------------------------------------------------------------------------------
// takes a string, and a char to split the string by. returns an array of strings.
// -------------------------------------------------------------------------------------
function ___split_string_by_char(str, splitter_char, bool_trim_end_spaces){
	
	var sub_str = "";
	var list = [];
	var splitter_length = string_length(splitter_char);
	
	/* 
	1. Loop through each letter.
	2. If no splitter char is found, add letter to the current substring.
	3. Else, if splitter char is found, add the current substring to array,
	   reset the substring, skip the splitter char so it doesnt get added.
	4. Return the array of substrings.
	*/
	
	for (var i = 1; i < string_length(str)+1; i++){
		
		var this_char = string_copy(str, i, splitter_length);
		
		if (this_char != splitter_char){
			sub_str = sub_str + this_char;
		
		} else {
		if (bool_trim_end_spaces) sub_str = ___string_trim_whitespace(sub_str);
			if (sub_str != "") list[array_length(list)] = sub_str;
			sub_str = "";
			i += splitter_length-1;
		}
	}
	
	if (bool_trim_end_spaces) sub_str = ___string_trim_whitespace(sub_str);
	if (string_length(sub_str) > 0) list[array_length(list)] = sub_str;
	
	return list;
}

// -------------------------------------------------------------------------------------
// trims whitespace from start and end of a string
// -------------------------------------------------------------------------------------
function ___string_trim_whitespace(str){
	
	while (string_char_at(str, 1) == " ") str = string_copy(str, 2, string_length(str)-1);
	while (string_char_at(str, string_length(str)) == " ") str = string_copy(str, 1, string_length(str)-1);
	return str;			
}

// -------------------------------------------------------------------------------------
// removes tags from a text string
// -------------------------------------------------------------------------------------
function ___string_strip_tags(string_to_strip){
	
	string_to_strip = string_replace_all(string_to_strip, "£", "");
	
	string_to_strip = ___DTA_fix_end_tag(string_to_strip);
	var old_str = string_to_strip;
	var new_str = "";
	
	for (var i = 1; i < string_length(old_str)+1; i++){
		
		var this_char = string_char_at(old_str, i);
		
		if (this_char = "<"){
			while(string_char_at(old_str, i) != ">") && (i < string_length(old_str)+1) i += 1;
		} else {
			new_str += this_char;
		}
	}
	
	return new_str;
	
}

// -------------------------------------------------------------------------------------
/* sometimes broken tags will be passed in to ___draw_text_advanced at the end of the string,
	this is caused by drawing strings one letter at a time. this function removes broken end tags.
	example: "<shake>HELLO<sha" becomes "<shake>HELLO" */
// -------------------------------------------------------------------------------------
function ___DTA_fix_end_tag(str){
	
	for (var i = string_length(str); i > 0; i--){
		var this_char = string_char_at(str, i);
		if (this_char ==">"){
			break;
		} else if (this_char == "<") {
			str = string_copy(str, 1, i-1);
		}
		
	}
	
	return str;
}

// -------------------------------------------------------------------------------------
// returns width of the longest line in a ___draw_text_advanced string (tags are ignored)
// -------------------------------------------------------------------------------------
function ___draw_text_advanced_width(str, _hsep){
	
	str = ___string_strip_tags(str);
	var letter_width = string_width("M") + _hsep;
	var line_list = ___split_string_by_char(str, "\n", false);
	var longest_line = 0;
	for (var i = 0; i < array_length(line_list); i++){
		longest_line = max(longest_line, string_length(line_list[i]));
	}
	
	return (longest_line * letter_width) - _hsep;
}

// -------------------------------------------------------------------------------------
// returns width of a specified line in a string (the width if based on draw_string_advanced.
// 0 is the index of the first line
// -------------------------------------------------------------------------------------
function ___DTA_return_line_width(str, line, letter_spacing){
	
	str = ___string_strip_tags(str);
	
	var starting_index = 1;
	var letter_w = string_width("M") + letter_spacing;
	
	// remove everything before the seleted line
	while(line > 0){
		starting_index = string_pos("\n", str);
		str = string_delete(str, 1, starting_index);
		line -=1;
	}
	
	// remove everything after the selected line
	var next_linebreak = string_pos("\n", str);
	if (next_linebreak != 0) str = string_copy(str, 1, next_linebreak-1);
	
	// multiply string length by letter width
	var line_len = string_length(str);
	var line_width = line_len * letter_w;
	// remove space after last letter since it is redundant 
	line_width = max(0, line_width - letter_spacing);
	
	return line_width;
}

// -------------------------------------------------------------------------------------
// linebreak strings by char count, ignores tags
// -------------------------------------------------------------------------------------
function _DTA_linebreak_chars(str, max_line) {
	

	//syntax: scr_linebreak("string",maxCharsBeforeLinebreak);

	/*
	This script will take a string as its first argument, 
	The second argument should be the number of characters you want to display on a line
	before a linebreak.

	Important: 
	This script takes into account my tag system (<example></example>).
	when it reaches as an angle bracket "<" it will skip that character 
	and keep skipping characters until it reaches a ">". The skipped characters are not
	included in the count towards a linebreak.

	"£" characters will also be skipped, as these are used for pauses when text is 
	being written.

	If you want to prematurely break a line, just use a "\n" symbol in the string 
	at the point you want it to break.

	*/

	var i = 0;
	var prev = 0;
	var tmp = 0;
	var insert = 1;
	var pause_char = "£";

	for (i = 1; i < string_length(str)+1; i++){

		if (string_char_at(str,i) == "\n"){
		    insert = 0;
		    continue;
		}
    
		if (string_char_at(str,i) == "<"){
		        while (string_char_at(str,i) != ">") i += 1;
		        continue;
		}
    
		if (string_char_at(str,i) == pause_char){
		    continue;
		}
    
		if (insert >= max_line){
        
		    prev = 0;
		    tmp = 0;
		    while (string_char_at(str, i - prev) != " ") && (prev < (max_line + tmp)){
			    if (string_char_at(str,i-prev -tmp) == ">"){
			        while (string_char_at(str,i-prev -tmp) != "<") tmp +=1;
			    }
			    prev += 1;
		    }
        
		    if (prev == max_line + tmp) {
		        str = string_insert("\n",str,i);
		    } else {
		        str = string_insert("\n",str,i - prev);
		        str = string_delete(str,i-prev + 1,1);  
		    }
		    i = 0;
		    insert = 0;
		    continue;
		}
    
    
		insert += 1;
	}

	return str;

}

// -------------------------------------------------------------------------------------
// linebreak strings by pixel width, ignores tags
// -------------------------------------------------------------------------------------
function ___DTA_linebreak_pixels(str, max_line_in_pixels, fnt, _OPT_letter_spacing) {
	if (0) return argument[0];
	
	var store_font = draw_get_font();
	draw_set_font(fnt);
	if (is_undefined(_OPT_letter_spacing)) _OPT_letter_spacing = 0;
	var char_width = string_width("M") + _OPT_letter_spacing;
	var max_chars_in_width = (max_line_in_pixels div char_width)-1;
	return _DTA_linebreak_chars(str, max_chars_in_width);
	draw_set_font(store_font);
}

// -------------------------------------------------------------------------------------
// combine array of strings into one string
// -------------------------------------------------------------------------------------
function ___DTA_combine_array_strings(array){
	
	str = ""
	for (var i = 0; i < array_length(array); i++) str += array[i];
	return str;
}

}