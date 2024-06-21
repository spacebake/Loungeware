function baku_mine_model_plane(){
vb_plane = vertex_create_buffer();
vertex_begin(vb_plane, format);

vertex_position_3d(vb_plane, -16.000000000,16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,1.000000000,0.000000000);

vertex_position_3d(vb_plane, 16.000000000,-16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,0.000000000,1.000000000);

vertex_position_3d(vb_plane, 16.000000000,16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,0.000000000,0.000000000);

vertex_position_3d(vb_plane, -16.000000000,16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,1.000000000,0.000000000);

vertex_position_3d(vb_plane, -16.000000000,-16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,1.000000000,1.000000000);

vertex_position_3d(vb_plane, 16.000000000,-16.000000000,0.000000000);
vertex_normal(vb_plane, 0.000000000,0.000000000,1.000000000);
vertex_color(vb_plane, c_white, 1 );
vertex_texcoord(vb_plane,0.000000000,1.000000000);

vertex_end(vb_plane);
vertex_freeze(vb_plane);
}