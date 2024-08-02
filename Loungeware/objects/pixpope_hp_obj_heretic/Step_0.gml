/// @description
x = xstart;
y = ystart;
image_angle = 0;
image_xscale = 1;
image_yscale = image_xscale;
timer++;

switch(state){
  case 0:  
    shakeSquirmAndWail()
  break;
    
  case 1:
    shakeSquirmAndWail();
    instance_create_depth(x, y, depth-1, pixpope_hp_obj_flare);  
    if(timer > flashLength){
      state = 2;  
      sprite_index = pixpope_hp_spr_gamemaker;
      instance_create_depth(x, y, depth-1, pixpope_hp_obj_radial_flare);
    }
  case 2:
    image_angle = sin(timer/15) * 10;
    image_xscale = 1 + sin(timer/10)*.05;
    image_yscale = image_xscale;
  break;
}



