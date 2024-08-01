/// @description Methods
checkProgressBreakpoint = function(){
  var _prevBest = bestProgress;
  bestProgress = max(progress, bestProgress);
  if(_prevBest < .33 && bestProgress >= .33){
    sprite_index = pixpope_spr_pope_angled;
    alarm[0] = 30;
  } else if(_prevBest < .66 && bestProgress >= .66){
    sprite_index = pixpope_spr_pope_angled;
    alarm[0] = 30;
  } else if(_prevBest < 1 && bestProgress >= 1){
    sprite_index = pixpope_spr_pope_angled;
    alarm[0] = 30;
  }
}

drawInstructions = function(){
  var _w = sprite_get_width(spr_button_a);
  var _h = sprite_get_height(spr_button_a);
  var _pressed = round(timer / 7);
  var _x1 = room_width / 2 - _w -_w / 2;
  var _x2 = room_width / 2 + _w / 2;
  var _y = y - _h;
  
  draw_sprite(spr_button_a, _pressed, _x1, _y)
  draw_sprite(spr_button_b, _pressed+1, _x2, _y)
}