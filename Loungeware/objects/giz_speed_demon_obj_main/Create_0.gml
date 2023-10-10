giz_init;

z = 32;

// Camera
giz.d3d.enable();
giz.camera.first_person = false;
giz.camera.position = giz.math.vec3(x, y, z);
giz.camera.rotation.y = 90;

// Environment
giz.d3d.environment.set_skybox(
	giz.d3d.load_sprite("giz/speed_demon/mtl_skybox.jpg")
);

// Model
//t=undefined, n=undefined, a=undefined, r=undefined, m=undefined, e=undefined
var mat = giz.d3d.material(
	giz.d3d.load_sprite("giz/speed_demon/mtl_diamond/diamond_color.jpg"), 
	giz.d3d.load_sprite("giz/speed_demon/mtl_diamond/diamond_normal.jpg"), 
	giz.d3d.load_sprite("giz/speed_demon/mtl_diamond/diamond_ao.jpg"), 
	giz.d3d.load_sprite("giz/speed_demon/mtl_diamond/diamond_roughness.jpg"), 
	giz.d3d.load_sprite("giz/speed_demon/mtl_diamond/diamond_metal.jpg")
);

model = giz.d3d.model(giz.d3d.primitive.sphere, mat);
model.scale = giz.math.vec3(32);
model.position = giz.math.vec3(giz.camera.position);

giz.d3d.render.add(model.draw);