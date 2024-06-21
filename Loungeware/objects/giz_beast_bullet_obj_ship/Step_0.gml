if ( giz.game.finished ) exit;
var input_x = ( KEY_RIGHT - KEY_LEFT );
var input_y = ( KEY_DOWN - KEY_UP );

hsp = lerp(hsp, input_x * 4, .3);
vsp = lerp(vsp, input_y * 4, .3);

x += hsp;
y += vsp;
x = clamp(x, 32, room_width - 32);
y = clamp(y, 32, room_height -32);

layer_x("Background", -x/10);
layer_y("Background", -y/10);

if ( --wait > 0 ) exit;
create_bullet();
bullet = giz_beast_bullet_get_phase()+1;//+ 3;
