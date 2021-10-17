/// @description 
if (state == "load" && async_load[? "id"] == request_id){
		
		var _response = json_parse(json_encode(async_load));
		if (variable_struct_get(_response, "id") == request_id){

			if  (variable_struct_get(_response, "status") >= 0){
				var _return_obj = json_parse(variable_struct_get(_response, "result"));
				var _is_error = "true" == variable_struct_get(_return_obj, "is_error");
 
				if (_is_error){
					throw_http_error(variable_struct_get(_return_obj, "error_msg"));
				} else {
					___state_change("board_display");
					show_message(variable_struct_get(_return_obj, "score_data"));
					//leaderboard_data = 
				}
			} else {
				throw_http_error("Server Error: " + string(variable_struct_get(_response, "http_status")));
			}
		} 	
}