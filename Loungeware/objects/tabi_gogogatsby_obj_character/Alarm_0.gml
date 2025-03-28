
if tabi_value_in_array(tabi_gogogatsby_obj_controller.character_array, tabi_gogogatsby_obj_controller.random_character_index) = false
{
	newest_character = instance_create_depth(500, lane_number = 1 ? 215 : 280, lane_number = 1 ? 100 : -100, tabi_gogogatsby_obj_character)
	newest_character.image_index = tabi_gogogatsby_obj_controller.random_character_index
	array_push(tabi_gogogatsby_obj_controller.character_array ,tabi_gogogatsby_obj_controller.random_character_index)
}
tabi_gogogatsby_obj_controller.random_character_index = irandom(4)


