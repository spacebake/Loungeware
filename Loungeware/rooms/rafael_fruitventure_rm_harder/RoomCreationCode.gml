randomic = irandom(2) 
if randomic = 0
{
	instance_activate_layer("FloorPink");
	layer_set_visible("Background1",true);
	layer_set_visible("FloorPink",true);
}
if randomic = 1
{
	instance_activate_layer("FloorOrange");
	layer_set_visible("Background2",true);
	layer_set_visible("FloorOrange",true);
}
if randomic = 2
{
	instance_activate_layer("FloorTurquoise");
	layer_set_visible("Background3",true);
	layer_set_visible("FloorTurquoise",true);
}
microgame_set_timer_max(11);