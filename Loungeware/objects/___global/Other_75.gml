/// @description 
var _type = async_load[? "event_type"];
var _index = async_load[? "pad_index"];

if (_type == "gamepad discovered") {
	controller_values[_index] = ___new_controller();
	controller_values[_index].active = true;
}