/// @desc Initialise the gameloop.
gml_pragma("global", @'global.jamDifficulty = 0;global.jamHp = 0;global.jamHpPool = 0;');
//katsaii_witchwanda_obj_title.visible = false;
hpMax = 7.5;
global.jamHp = hpMax;
global.jamHpPool = 0;
//global.jamScore = 0;
difficultyLevels = katsaii_witchwanda_get_difficulty_levels();
global.jamDifficulty = 0;
var difficulty_ids = [12, 16, 20, 24, 28];
global.jamCurrentDifficultyLevelID = difficulty_ids[DIFFICULTY - 1];
//global.jamHighScore = 0;
difficultyLevel = global.jamCurrentDifficultyLevelID;
for (var i = 0; i < difficultyLevel; i += 4) {
    global.jamDifficulty += difficultyLevels[i + 0];
}
difficultyThreshold = global.jamDifficulty + difficultyLevels[difficultyLevel + 0];
var start_diff_offset = -0.40;
global.jamDifficulty += 0; //start_diff_offset;
difficultyGain = 0.002;
hpDrain = 0.0075;
hpRecover = 0.1;
fadeIn = 0;
fadeInCounter = 0.005;
fadeOut = 0;
fadeOutCounter = 0.01;
gameRestart = false;
gameRestartTimer = 1;
gameRestartCounter = 0.01;
gameOver = false;
audio_stop_sound(katsaii_witchwanda_bgm_finish_bad);
audio_stop_sound(katsaii_witchwanda_snd_crumble);
audio_stop_sound(katsaii_witchwanda_bgm_gameplay);
gameOverSound = sfx_play(katsaii_witchwanda_bgm_finish_bad, 0, true);
crumbleSound = sfx_play(katsaii_witchwanda_snd_crumble, 0, true);
musicSound = sfx_play(katsaii_witchwanda_bgm_gameplay, 0, true);
musicFade = -0.25;
musicFadeCounter = 0.01;
gameOverSurface = -1;
spawnWave = true;
gameWon = false;
waveStates = ds_list_create();
for (var i = 0; i <= 12; i += 1) {
   ds_list_add(waveStates, i);
}