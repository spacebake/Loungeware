landed = false;
touched_ground = false;


image_xscale = width / sprite_width;
image_yscale = height / sprite_height;
fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, width / 2, height / 2);
physics_fixture_set_density(fixture, 1);
physics_fixture_set_restitution(fixture, 0.1);
physics_fixture_set_collision_group(fixture, 1);
physics_fixture_set_linear_damping(fixture, 0.1);
physics_fixture_set_angular_damping(fixture, 0.1);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_bind_ext(fixture, id, -width / 2, -height / 2);
physics_fixture_delete(fixture);



