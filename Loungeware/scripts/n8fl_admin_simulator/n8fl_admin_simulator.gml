enum n8fl_admin_simulator_EMessageType {
	Ban,
	Okay
}

function n8fl_admin_simulator_FMessage(type, text) constructor
{
	_type = type;
	_text = text;
	
	static get_type = function(){ return _type;	 }
	static get_text = function(){ return _text; }
}

function n8fl_admin_simulator_FMember(name, colour, image_index) constructor
{
	_name = name;
	_colour = colour;
	_image_index = image_index;
	
	static get_colour = function(){ return _colour; }
	static get_name = function(){ return _name;	 }
	static get_image_index = function(){ return _image_index; }
}