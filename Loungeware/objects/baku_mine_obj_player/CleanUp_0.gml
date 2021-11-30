
// Disable 3D
disable_3d();

// Delete surfaces
if surface_exists(surf_gui) surface_free(surf_gui);

// Delete format
vertex_format_delete(format);