function baku_mine_model_block_static(_buff, _x, _y, _z, _coords){
		
	var _size = 8.00;	
	vertex_position_3d(_buff, _x+_size, _y+_size, _z+_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x+_size,_y-_size,_z-_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.00 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y+_size,_z-_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 1.00 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.750 * _coords.w ), _coords.y + ( 0.50 *_coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 1.00 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z+_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.750 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y+_size,_z-_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 *_coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z-_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.750 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + (0.250 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.250 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.250 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 1.00 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y+_size,_z+_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z+_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.00 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z-_size);
	vertex_normal(_buff, 1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.00 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 1.00 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.750 * _coords.w ),_coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,-1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.750 * _coords.w ),_coords.y + ( 0.50 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y-_size,_z+_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.750 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y+_size,_z+_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y+_size,_z-_size);
	vertex_normal(_buff, -1.00,0.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x+_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));

	vertex_position_3d(_buff, _x+_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,1.00,0.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ) , _coords.y + ( 0.50 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y-_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.250 * _coords.h ));

	vertex_position_3d(_buff, _x-_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.50 * _coords.h ));

	vertex_position_3d(_buff, _x+_size,_y+_size,_z-_size);
	vertex_normal(_buff, 0.00,0.00,-1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff, _coords.x + ( 0.250 * _coords.w ),_coords .y + ( 0.50 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y+_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 0.750 * _coords.h ));
	
	vertex_position_3d(_buff, _x-_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.50 * _coords.w ), _coords.y + ( 1.00 * _coords.h ));
	
	vertex_position_3d(_buff, _x+_size,_y-_size,_z+_size);
	vertex_normal(_buff, 0.00,0.00,1.00);
	vertex_color(_buff, c_white, 1 );
	vertex_texcoord(_buff,_coords.x + ( 0.250 * _coords.w ), _coords.y + ( 1.00 * _coords.h ));
	
}