/// @description
switch(state){
  
  case 0: 
    timer++;
    if(timer % autoDecay == 0) progress -= decay;
    progress = clamp(progress, 0, 1);
    
    var _pressed = KEY_PRIMARY_PRESSED - KEY_SECONDARY_PRESSED
    if(_pressed == 0) exit;

    if(_pressed != lastPressed)
      progress += gain;
    else 
      progress -= decay;
    
    progress = clamp(progress, 0, 1);
    lastPressed = _pressed;
    checkProgressBreakpoint();

    if(progress >= 1){
      microgame_win();
      state++;
      array_foreach(hereticList, function(_x){
        with(_x) onPurge();  
      })
    }
    break;
}