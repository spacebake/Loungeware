/// @desc Make the title visible again.
instance_destroy(katsaii_witchwanda_obj_wanda_projectile);
ds_list_destroy(waveStates);
if (surface_exists(gameOverSurface)) {
    surface_free(gameOverSurface);
}
//katsaii_witchwanda_obj_title.visible = true;
//if (global.jamHighScore < global.jamScore) {
    //global.jamHighScore = global.jamScore;
//}
global.jamHp = 0;
with (katsaii_witchwanda_obj_enemy) {
    event_user(0);
}