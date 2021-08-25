/// @desc Save high score.
audio_emitter_free(selectionEmitter);
audio_emitter_free(musicEmitter);
if (surface_exists(titleSurface)) {
    surface_free(titleSurface);
}
ini_open("minigame/data.ini");
if (global.jamScore > 0 && global.jamScore > global.jamHighScore) {
    ini_write_real("achievements", "score", global.jamScore);
}
var max_level = string_lower(global.jamMaxDifficultyLevel);
if (max_level != "trivial") {
    ini_write_string("achievements", "level", max_level);
}
ini_close();