if (async_load[? "id"] == post_id){
	show_message(json_encode(async_load));
	exit;
}
// handle submission confirmation
//if (state == "confirmation_screen" && substate == 4){
	if (async_load[? "id"] == post_id){
		show_debug_message(json_encode(async_load));
		var _response = json_parse(json_encode(async_load));
		if (variable_struct_get(_response, "id") == post_id){
			show_debug_message("http response");

			if  (variable_struct_get(_response, "status") >= 0){
				var _return_obj = json_parse(variable_struct_get(_response, "result"));
				var _is_error = "true" == variable_struct_get(_return_obj, "is_error");
 
				if (_is_error){
					throw_http_error(variable_struct_get(_return_obj, "error_msg"));
				} else {
					// success, go to high score screen
				}
			} else {
				throw_http_error("Server Error: " + string(variable_struct_get(_response, "http_status")));
			}
	
		} 
	}
//}