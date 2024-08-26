/// @description
image_xscale = 1;
image_yscale = image_xscale;

event_user(0); //Movement
event_user(1); //Targeting

partSystem = part_system_create()
part_system_depth(partSystem, depth - 10);


partSystemBehind = part_system_create()
part_system_depth(partSystemBehind, layer_get_depth("Backgrounds_1")-1);

list = ds_list_create()
enemies = [
	[layer_get_id("Difficulty1A"), layer_get_id("Difficulty1B"), layer_get_id("Difficulty1C")],
	[layer_get_id("Difficulty2A"), layer_get_id("Difficulty2B"), layer_get_id("Difficulty2C"), layer_get_id("Difficulty2D"), layer_get_id("Difficulty2E")],
	[layer_get_id("Difficulty3A"), layer_get_id("Difficulty3B")],
	[layer_get_id("Difficulty4")],
	[layer_get_id("Difficulty5")]
]

//Deactivate all layers
pixpope_array_foreach(enemies, function(_diff, _i){
	pixpope_array_foreach(_diff, function(_layer, _i){
		show_debug_message("Disabling: " + layer_get_name(_layer))
		instance_deactivate_layer(_layer);	
	})
})

tile_layer_id = layer_tilemap_get_id(layer_get_id("Tiles_1"))

var _diffLayers = array_shuffle(enemies[DIFFICULTY-1]);
instance_activate_layer(_diffLayers[0]);
layer_set_visible(_diffLayers[0], true);
show_debug_message("Activating: " + layer_get_name(_diffLayers[0]));

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