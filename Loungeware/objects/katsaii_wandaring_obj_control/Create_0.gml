/// @desc Initialise controller and load the room.
angle = 45;
pitch = 50;
posX = 0;
posY = 0;
posZ = 0;
depth = 10000; // draw the background first uwu
// initialise colours
colours = [
    KATSAII_WANDARING_FOLIAGE_BLUE,
    KATSAII_WANDARING_FOLIAGE_GREEN,
    KATSAII_WANDARING_FOLIAGE_GREY,
    KATSAII_WANDARING_FOLIAGE_GREEN_2,
    KATSAII_WANDARING_FOLIAGE_YELLOW,
    KATSAII_WANDARING_FOLIAGE_PINK,
    KATSAII_WANDARING_FOLIAGE_PURPLE,
    KATSAII_WANDARING_FOLIAGE_ORANGE,
    KATSAII_WANDARING_FOLIAGE_RED,
    KATSAII_WANDARING_FOLIAGE_ORANGE_2,
];
array_sort(colours, function(_a, _b) {
    return choose(-1, 0, 1);
});
// mirror state
mirrorX = choose(1, -1);
mirrorY = choose(1, -1);
// load room
katsaii_wandaring_generate_random_room();
mirrorX = 1;
mirrorY = 1;
var snd = sfx_play(katsaii_wandaring_bgm_music, 0, true);
audio_sound_gain(snd, 0.125, game_get_speed(gamespeed_microseconds) * 2 / 10);
// set view
view_enabled = true;
view_set_visible(0, true);
camera_set_view_pos(view_camera[0], -floor(room_width / 2), -floor(room_height / 1.25));