/// @description Methods
chargeStaff = function(){
  sprite_index = pixpope_hp_spr_pope_angled;
  instance_create_depth(x+17, y-110, depth-1,pixpope_hp_obj_radial_flare);
  alarm[0] = 30;
}


checkProgressBreakpoint = function(){
  var _prevBest = bestProgress;
  bestProgress = max(progress, bestProgress);
  if(_prevBest < .33 && bestProgress >= .33){
    chargeStaff();
  } else if(_prevBest < .66 && bestProgress >= .66){
    chargeStaff();
  } else if(_prevBest < 1 && bestProgress >= 1){
    chargeStaff();
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

onWin = function(){
  microgame_win();
  state++;
  tfg_array_foreach(hereticList, function(_x){
    with(_x) onPurge();  
  })
  instance_create_depth(0,0,depth-100,pixpope_hp_obj_blessed);
  instance_create_depth(0,0,0,pixpope_hp_obj_screenflash);
  sfx_play(pixpope_hp_chior)
  
  part_emitter_stream(system, emitter, type, 30);
  
  alarm[1] = 30;
  part_emitter_region(system, emitter, -room_width, room_width, 0, 0, ps_shape_line, ps_distr_linear);
  sprite_index = pixpope_hp_spr_pope_angled;
}