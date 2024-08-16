/// @description
image_xscale = .5;
image_yscale = image_xscale;

event_user(0); //Movement
event_user(1); //Targeting

list = ds_list_create()
enemies = [
	layer_get_id("Difficulty1"),
	layer_get_id("Difficulty2"),
	layer_get_id("Difficulty3"),
	layer_get_id("Difficulty4"),
	layer_get_id("Difficulty5")
]

pixpope_array_foreach(enemies, function(_layer, _i){
	if(_i+1 == DIFFICULTY) {
		layer_set_visible(_layer, true)
		return;
	}
	instance_deactivate_layer(_layer);	
})

//switch(DIFFICULTY){
//  case 2: 
//    activeLayer = ; 
//    break;
//  case 3: 
//    activeLayer = layer_get_id("HereticsHard"); 
//    break;
//  case 4: 
//    activeLayer = layer_get_id("HereticsHarder"); 
//    break;
//  case 5: 
//    activeLayer = layer_get_id("HereticsHardest"); 
//    break;
//}