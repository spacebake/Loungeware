/// @description
checkWin();

move()
var _isLockOn = (KEY_PRIMARY || KEY_SECONDARY) && !instance_exists(pixpope_lod_obj_laser);
updateLockOn(_isLockOn);

if(_isLockOn) aquireTargets();
if(KEY_PRIMARY_RELEASED || KEY_SECONDARY_RELEASED) fire();