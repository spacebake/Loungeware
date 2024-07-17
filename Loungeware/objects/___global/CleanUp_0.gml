ds_list_destroy(___song_stop_list);
ds_list_destroy(___audio_active_list);

ds_map_destroy(gp_to_str);
ds_map_destroy(_DTA_FONT_Y_OFFSET_MAP);

// text alive
ds_list_destroy(active_char_id_list);
ds_list_destroy(active_char_timer_list);
ds_list_destroy(active_char_potential_letters);

font_delete(___fnt_transition_score);
font_delete(___fnt_gallery);

