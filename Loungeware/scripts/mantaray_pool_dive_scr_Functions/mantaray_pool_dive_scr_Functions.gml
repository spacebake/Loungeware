function mantaray_pool_dive_fnc_projectile_motion(_t, _v0, _angle, _g) {	
	return {x: _v0 * dcos(_angle) * _t, 
			y: _v0 * dsin(_angle) * _t - 1/2 * _g * power(_t,2)};
}
