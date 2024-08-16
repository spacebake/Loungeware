/// @description

checkWin();

move()
updateLockOn();

var _lockOn = KEY_PRIMARY || KEY_SECONDARY;
if(_lockOn) 
  aquireTargets();

if(KEY_PRIMARY_RELEASED || KEY_SECONDARY_RELEASED) {
  fire();
}