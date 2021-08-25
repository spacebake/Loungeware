/// @desc Initialise the title.
optionThreshold = 0.7;
creditThreshold = 0.3;
ini_open("minigame/data.ini");
global.jamHighScore = max(ini_read_real("achievements", "score", 0), 0);
global.jamScore = 0;
global.jamMaxDifficultyLevel = string_upper(ini_read_string("achievements", "level", "trivial"));
global.jamCurrentDifficultyLevelID = 0;
difficultyLevels = jam_get_difficulty_levels();
var difficulty_count = array_length(difficultyLevels);
var valid_difficulty = false;
for (var i = 0; i < difficulty_count; i += 4) {
    if (global.jamMaxDifficultyLevel == difficultyLevels[i + 2]) {
        valid_difficulty = true;
        break;
    }
}
if not (valid_difficulty) {
    global.jamMaxDifficultyLevel = "TRIVIAL";
}
ini_close();
selection = 0;
selectionSubmit = false;
selectionEmitter = audio_emitter_create();
musicEmitter = audio_emitter_create();
introTimer = 0;
introCounter = 0.03;
musicFade = 0;
musicFadeCounter = 0.005;
titleSurface = -1;
mouseMovement = false;
mouseX = 0;
mouseY = 0;
wandaX = 0;
wandaY = 0;
audio_emitter_gain(musicEmitter, 0);