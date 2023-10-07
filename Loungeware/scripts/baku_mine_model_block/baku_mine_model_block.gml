function baku_mine_model_block(){
vb_cube = vertex_create_buffer();
vertex_begin(vb_cube, format);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,-0.000000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,1.000000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,1.000000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.250000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.250000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,1.000000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.000000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,-0.000000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,1.000000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,-1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.750000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, -1.000000000,0.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.750000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,1.000000000,0.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.250000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.500000000);

vertex_position_3d(vb_cube, 16.000000000,16.000000000,-16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,-1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,0.500000000);

vertex_position_3d(vb_cube, -16.000000000,16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,0.750000000);

vertex_position_3d(vb_cube, -16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.500000000,1.000000000);

vertex_position_3d(vb_cube, 16.000000000,-16.000000000,16.000000000);
vertex_normal(vb_cube, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_cube, c_white, 1 );
vertex_texcoord(vb_cube,0.250000000,1.000000000);

vertex_end(vb_cube);
vertex_freeze(vb_cube);
}