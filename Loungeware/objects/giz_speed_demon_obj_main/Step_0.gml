giz.camera.rotation.y += ( KEY_DOWN - KEY_UP ) * 5;
giz.camera.rotation.z += ( KEY_RIGHT - KEY_LEFT ) * 5;
giz.camera.rotation.y = clamp(giz.camera.rotation.y, 1, 179);

model.rotation.z+=.2;
giz.camera.distance += ( mouse_wheel_down() - mouse_wheel_up() ) * 8;
model.material.metallic.value = abs(dcos(current_time/100));
model.material.roughness.value = abs(dcos(current_time/50));
model.material.set_value("roughness");
model.material.set_value("metallic");