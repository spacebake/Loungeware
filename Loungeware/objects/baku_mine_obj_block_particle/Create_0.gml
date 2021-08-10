
event_inherited();
tex = choose(baku_mine_spr_stone, baku_mine_spr_stone_dark, baku_mine_spr_stone_darker);
var _scale = random_range(0.0625, 0.125);
scale_x = _scale;
scale_y = _scale;
scale_z = _scale;
model_type = "block";
grav = 0.075;
z_spd = random_range(1, 1.5);
dir = random(360);
spd = (2 - z_spd) / 2;