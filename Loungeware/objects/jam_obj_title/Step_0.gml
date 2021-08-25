/// @desc Update selection.
if (introTimer < 1) {
    introTimer += introCounter;
    if (introTimer >= 1) {
        audio_play_sound_on(musicEmitter, jam_bgm_title, true, 100);
    } else {
        exit;
    }
}
audio_emitter_gain(musicEmitter, musicFade * 0.18);
if not (visible) {
    musicFade -= musicFadeCounter * 2;
    if (musicFade < 0) {
        musicFade = 0;
    }
    exit;
} else {
    musicFade += musicFadeCounter;
    if (musicFade > 1) {
        musicFade = 1;
    }
}
var cam = KATSAII_WITCH_WANDA_VIEW_CAM;
var cam_left = camera_get_view_x(cam);
var cam_top = camera_get_view_y(cam);
var cam_right = cam_left + camera_get_view_width(cam);
var cam_bottom = cam_top + camera_get_view_height(cam);
var cam_xcentre = mean(cam_left, cam_right);
var prev_selection = selection;
var next_mouse_x = mouse_x;
var next_mouse_y = mouse_y;
if (next_mouse_x != mouseX || next_mouse_y != mouseY) {
    mouseX = next_mouse_x;
    mouseY = next_mouse_y;
    mouseMovement = true;
}
if (instance_exists(jam_obj_wanda)) {
    var next_wanda_x = jam_obj_wanda.x;
    var next_wanda_y = jam_obj_wanda.y;
    if (next_wanda_x != wandaX || next_wanda_y != wandaY) {
        wandaX = next_wanda_x;
        wandaY = next_wanda_y;
        mouseMovement = false;
    }
}
if (mouse_check_button_pressed(mb_left)) {
    mouseMovement = true;
} else if (keyboard_check_pressed(vk_enter)) {
    mouseMovement = false;
}
var cursor_x = mouseMovement ? mouseX : wandaX;
var cursor_y = mouseMovement ? mouseY : wandaY;
selection = cursor_y > lerp(cam_top, cam_bottom, optionThreshold);
if (selection == 0 && cursor_y < lerp(cam_top, cam_bottom, creditThreshold)) {
    selection = 2 + (cursor_x > mean(cam_left, cam_right));
}
if (prev_selection != selection) {
    audio_emitter_gain(selectionEmitter, random_range(0.5, 0.7));
    audio_emitter_pitch(selectionEmitter, random_range(0.5, 0.7));
    audio_play_sound_on(selectionEmitter, jam_snd_select, false, 1);
}
if (!selectionSubmit && keyboard_check_pressed(vk_enter)) {
    selectionSubmit = true;
}
var make_selection = false;
with (jam_obj_wanda_projectile) {
    if (x > cam_xcentre) {
        make_selection = true;
        break;
    }
}
if (selectionSubmit && make_selection || mouse_check_button_pressed(mb_left)) {
    selectionSubmit = false;
    audio_emitter_gain(selectionEmitter, random_range(0.7, 1.0));
    audio_emitter_pitch(selectionEmitter, random_range(0.6, 0.9));
    audio_play_sound_on(selectionEmitter, jam_snd_select_confirm, false, 1);
    switch (selection) {
    case 0:
        instance_create_layer(x, y, layer, jam_obj_gameloop);
        break;
    case 1:
        transition_room_goto(rm_game_title);
        break;
    case 2:
        global.jamCurrentDifficultyLevelID -= 4;
        if (global.jamCurrentDifficultyLevelID < 0) {
            global.jamCurrentDifficultyLevelID = 0;
            var level_count = array_length(difficultyLevels);
            for (var i = 0; i < level_count; i += 4) {
                if (difficultyLevels[i + 2] == global.jamMaxDifficultyLevel) {
                    global.jamCurrentDifficultyLevelID = i;
                    break;
                }
            }
        }
        //url_open("http://nuxiigit.github.io/");
        break;
    case 3:
        if (difficultyLevels[global.jamCurrentDifficultyLevelID + 2] == global.jamMaxDifficultyLevel ||
                global.jamCurrentDifficultyLevelID + 4 >= array_length(difficultyLevels)) {
            global.jamCurrentDifficultyLevelID = 0;
        } else {
            global.jamCurrentDifficultyLevelID += 4;
        }
        //url_open("https://www.deviantart.com/mashmerlow");
        break;
    }
}