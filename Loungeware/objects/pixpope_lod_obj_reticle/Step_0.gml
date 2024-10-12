/// @description
checkWin();

move()
var _isLockOn = (KEY_PRIMARY || KEY_SECONDARY) && !instance_exists(pixpope_lod_obj_laser);
var _fully = updateLockOn(_isLockOn);

if(_fully) aquireTargets();
if(KEY_PRIMARY_RELEASED || KEY_SECONDARY_RELEASED) fire();