/// @desc Set up 3d and draw background.
katsaii_wandaring_rf3d_set_origin(posX, posY, posZ);
katsaii_wandaring_rf3d_set_orientation(angle, pitch);
if (instance_exists(katsaii_wandaring_obj_gameend)) {
    katsaii_wandaring_rf3d_set_orientation(angle + katsaii_wandaring_obj_gameend.timer * 180, pitch + katsaii_wandaring_obj_gameend.timer * 60);
}