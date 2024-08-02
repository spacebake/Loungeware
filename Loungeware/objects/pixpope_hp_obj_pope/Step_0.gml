/// @description
if(alarm[0] != -1)
  image_alpha = 1 - (alarm[0] / 30);

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
    
    part_emitter_stream(system, emitter, type, bestProgress == 0 ? 0 : lerp(-10, -1, bestProgress));
    if(progress >= 1){
      onWin();
    }
    break;
}