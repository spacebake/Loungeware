if (surface_exists(surf_master)) surface_free(surf_master);
if (surface_exists(surf_gameboy)) surface_free(surf_gameboy);
if (surface_exists(surf_transition_circle)) surface_free(surf_transition_circle);
if (surface_exists(surf_larold)) surface_free(surf_larold);
if (surface_exists(surf_cart)) surface_free(surf_cart);
ds_list_destroy(garbo_sprites);
___reset_draw_vars();
workspace_end();
application_surface_draw_enable(true);