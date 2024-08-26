/// @description
if(!instance_exists(target)) exit;
x = target.x;
y = target.y;

timer++
var _colPos = animcurve_channel_evaluate(colorCurve, timer / length)
var _scalePos = animcurve_channel_evaluate(scaleCurve, timer / length)
image_blend = merge_color(#f1f2db, #f45f5a, _colPos)
image_xscale = lerp(image_xscale, (sprite_get_width(target.sprite_index)+8) / sprite_get_width(sprite_index), _scalePos)
image_yscale = image_xscale;