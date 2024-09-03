/// @description
self[$ "target"] ??= noone;
sfx_play(pixpope_lod_sfx_lockon,,,random_range(.75,1.5));
timer = 0;
length = 30;
image_blend = #f1f2db
colorCurve = animcurve_get_channel(pixpope_lod_ac_locked_on, "color")
scaleCurve = animcurve_get_channel(pixpope_lod_ac_locked_on, "scale")