/// @description
timer++;
switch(state){
  case states.approach: 
    x = lerp(entryPoints.start[0], entryPoints.finish[0], animcurve_channel_evaluate(horiCurve, timer/length));
    y = lerp(entryPoints.start[1], entryPoints.finish[1], animcurve_channel_evaluate(vertCurve, timer/length));
    if(timer >= length) state = states.idle;
  break;
}

