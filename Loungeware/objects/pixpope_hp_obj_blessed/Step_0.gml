/// @description
timer++;
if(timer == 0)
  part_emitter_stream(ps, emitter, type, -10);
y = lerp(ystart, room_height+offset, animcurve_channel_evaluate(curve, timer / length));
image_angle = sin(timer / 10);
