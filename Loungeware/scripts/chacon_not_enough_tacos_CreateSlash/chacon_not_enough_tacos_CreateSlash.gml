// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CreateSlash(){
	repeat(choose(1, 2)){ // Create slash effect
		instance_create_layer(106 + random_range(-6, 6), 67 + random_range(-6, 6), "instances", chacon_not_enough_tacos_slash);
	}
}