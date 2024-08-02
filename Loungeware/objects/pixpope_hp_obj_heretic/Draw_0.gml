/// @description

switch(state){
  case 0:
  case 2: draw_self(); break;
  case 1:
    gpu_set_fog(true, c_white, -16000, 16000);
    draw_self();
    gpu_set_fog(false, 0, 0, 0);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, clamp(1 - (timer / flashLength), 0, 1))
  break;
}
