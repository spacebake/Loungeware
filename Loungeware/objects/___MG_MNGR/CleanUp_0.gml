if (surface_exists(surf_master)) surface_free(surf_master);
if (surface_exists(surf_gameboy)) surface_free(surf_gameboy);
if (surface_exists(surf_transition_circle)) surface_free(surf_transition_circle);
if (surface_exists(surf_reflection)) surface_free(surf_reflection);
if (surface_exists(ou_surf_circle)) surface_free(ou_surf_circle);
if (surface_exists(es_surf_circle)) surface_free(es_surf_circle);
if (surface_exists(ec_surface)) surface_free(ec_surface);

if sprite_exists(cart_sprite) sprite_delete(cart_sprite);
if sprite_exists(prompt_sprite) sprite_delete(prompt_sprite);

ds_list_destroy(transition_garbo_sprites);
___reset_draw_vars();
workspace_end();
//application_surface_draw_enable(true);

