if (state != "submit") exit;

var _response, _is_error, _return_obj, _has_result, _result_data, _has_score_data, _error_data_type;

show_debug_message(json_encode(async_load))
_response = json_parse(json_encode(async_load));
_has_result = variable_struct_exists(_response, "result");
_has_score_data = false;
if (_has_result){
	_result_data = variable_struct_get(_response, "result");
	try {
		if (typeof(_result_data) == "string") _result_data = json_parse(_result_data);
	}
	catch(_exception) {
		throw_http_error("SERVER DOIN SOMETHIN WEIRD");
		exit;
	}
	_has_score_data = variable_struct_exists(_result_data, "is_error");
}

/// @description 
if (async_load[? "id"] == post_id && _has_score_data){
		
	_return_obj = _response.result;
	if (typeof(_return_obj) == "string"){
		_return_obj = json_parse(_return_obj);
	}
	
	if (_return_obj.is_error){
		throw_http_error(string(variable_struct_get(_return_obj, "error_message")));
		
	} else {
		submission_successful = true;
	}
 	
} 