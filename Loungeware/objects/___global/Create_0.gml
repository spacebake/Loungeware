/* The one true global object,
this is created at the start of the game
and remains until the game is closed.
you can write to it using ___global.
do not use this object to store vars 
for your microgame, it is for base-game use only */


song_stop_list = ds_list_create(); //___ds_list_create_builtin();