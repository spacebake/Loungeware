
draw_set_color(c_white);
draw_clear($21171A);
draw_sprite(anti_dungeon_sp_back,back_ind,0,0);


//enemy
var enemyshakex = random_range(-enemyshake,enemyshake);
var enemyshakey = random_range(-enemyshake,enemyshake);
draw_sprite(enemy_spr,enemy_ind,room_width/2+enemyshakex,room_height/2+enemy_intro_y+enemyshakey);


//ui
draw_sprite(anti_dungeon_sp_ui,0,29,0);

drawnum_multi(35,6,enemyhealth_draw,enemyhealth_display);
drawnum_multi(54,6,enemyatk_draw,enemyatk);
drawnum_multi(74,6,enemymagic_draw,enemymagic);



//textbox
var tx = 15;
var ty = 63+(1-textbox_open)*20;
draw_sprite_ext(anti_dungeon_sp_box,textbox_ind,tx,ty,89/8,15/8,0,c_white,1);
//draw_sprite(anti_dungeon_sp_button,current_time/200,tx+89,ty);
if textbox_open >= .9 {
    draw_set_color($ffc89c);
    draw_text_ext_transformed(tx+4,ty+4,desc_draw,-1,250, .3,.3, 0);
}