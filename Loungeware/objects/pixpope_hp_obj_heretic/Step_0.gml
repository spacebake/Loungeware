/// @description
x = xstart;
y = ystart;
image_angle = 0;
image_xscale = 1;
image_yscale = image_xscale;

switch(state){
  case 0:  
    var _prog = pixpope_hp_obj_pope.bestProgress;

    var _shake = _prog * 10;
    x += random_range(-_shake, _shake);
    y += random_range(-_shake, _shake);
    
    if(_prog < .33) break;
    var _squirm = (_prog - .33) * 90;
    image_angle = random_range(-_squirm, _squirm);
    
    if(_prog < .66) break;
    var _wail = (_prog - .66) * .5;
    image_xscale += random_range(-_wail, _wail);
    image_yscale += random_range(-_wail, _wail);
    
  break;
    
  case 1:
  
  break;
}



