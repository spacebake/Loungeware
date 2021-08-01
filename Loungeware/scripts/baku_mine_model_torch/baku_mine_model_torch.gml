function baku_mine_model_torch(){
vb_torch = vertex_create_buffer();
vertex_begin(vb_torch, format);

vertex_position_3d(vb_torch, 2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,-0.000000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,1.000000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,1.000000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.250000000);

vertex_position_3d(vb_torch, 2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.250000000);

vertex_position_3d(vb_torch, -2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,1.000000000);

vertex_position_3d(vb_torch, 2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.000000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,-0.000000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,1.000000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.866000000,-0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.750000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, -1.000000000,-0.000000000,0.000000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.750000000);

vertex_position_3d(vb_torch, 2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.866000000,0.500000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,15.820909000,-10.560367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.250000000);

vertex_position_3d(vb_torch, -2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.500000000);

vertex_position_3d(vb_torch, 2.664000000,20.435093000,-7.896367000);
vertex_normal(vb_torch, 0.000000000,0.500000000,-0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,0.500000000);

vertex_position_3d(vb_torch, -2.664000000,9.779092000,10.560367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,0.750000000);

vertex_position_3d(vb_torch, -2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.500000000,1.000000000);

vertex_position_3d(vb_torch, 2.664000000,5.164908000,7.896367000);
vertex_normal(vb_torch, 0.000000000,-0.500000000,0.866000000);
vertex_color(vb_torch, c_white, 1 );
vertex_texcoord(vb_torch,0.250000000,1.000000000);

vertex_end(vb_torch);
}