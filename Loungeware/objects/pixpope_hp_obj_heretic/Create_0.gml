/// @description
state = 0;
timer = 0;
flashLength = 30;
onPurge = function(){
  state = 1;
  timer = irandom_range(-30, 0);
}


shakeSquirmAndWail = function(){
  
    var _prog = pixpope_hp_obj_pope.bestProgress;
    var _shake = _prog * 10;
    x += random_range(-_shake, _shake);
    y += random_range(-_shake, _shake);
    
    if(_prog < .33) return;
    var _squirm = (_prog - .33) * 90;
    image_angle = random_range(-_squirm, _squirm);
    
    if(_prog < .66) return;
    var _wail = (_prog - .66) * .5;
    image_xscale += random_range(-_wail, _wail);
    image_yscale += random_range(-_wail, _wail);  
}