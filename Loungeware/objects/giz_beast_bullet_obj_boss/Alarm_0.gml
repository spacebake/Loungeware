if ( giz.game.finished ) exit;
var _dir = giz.math.rand(360);
var _num = DIFFICULTY * 2;//giz.math.irand(2, (phase + 2)*2);
repeat(_num){
	giz_beast_bullet_create_tentacle(x+lengthdir_x(24, _dir), y+lengthdir_y(24, _dir), _dir, colors[phase]);
	_dir += ( 360 / _num );
}

alarm[0] = 60;