 /// @description
state = 0;

activeLayer = layer_get_id("HereticsEasy");
progress = 0;
bestProgress = 0;
gain = .03;
decay = 0;
autoDecay = 10;
timer = 0;
lastPressed = undefined;

switch(DIFFICULTY){
  case 2: 
    activeLayer = layer_get_id("HereticsMedium"); 
    decay = .01;
    break;
  case 3: 
    activeLayer = layer_get_id("HereticsHard"); 
    decay = .02;
    break;
  case 4: 
    activeLayer = layer_get_id("HereticsHarder"); 
    decay = .03;
    break;
  case 5: 
    activeLayer = layer_get_id("HereticsHardest"); 
    decay = .035;
    break;
}

layer_set_visible(activeLayer, true);
var _hereticSprites = array_shuffle([
  pixpope_hp_spr_godot,
  pixpope_hp_spr_cry,
  pixpope_hp_spr_construct,
  pixpope_hp_spr_unity,
  pixpope_hp_spr_unreal,
  pixpope_hp_spr_monogame
])
hereticList = [];
var _depth = layer_get_depth(activeLayer);
with(pixpope_hp_obj_heretic)
{
  if(depth != _depth) continue;
  sprite_index = array_pop(_hereticSprites);
  array_push(other.hereticList, id);
}

event_user(0);
event_user(1);