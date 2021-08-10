leftScope = instance_create_layer(16, 80, "Scopes", jdllama_target_obj_scope);
middleScope = instance_create_layer(120, 80, "Scopes", jdllama_target_obj_scope);
rightScope = instance_create_layer(224, 80,  "Scopes", jdllama_target_obj_scope);

_step = function() {
	leftScope.scopeActive = false; 
	middleScope.scopeActive = false;
	rightScope.scopeActive = false;
	
	if(KEY_LEFT) {
		leftScope.scopeActive = true;
	}
	else if(KEY_RIGHT) {
		rightScope.scopeActive = true;
	}
	else {
		middleScope.scopeActive = true;
	}
}