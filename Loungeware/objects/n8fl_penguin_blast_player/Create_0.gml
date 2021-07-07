enum n8fl_penguin_blast_EPlayerAnimation{
	Idle,
	Primary,
	Secondary,
	Dodge,
	Hurt
}

image_speed = 0;
game_t = 0;

score_total = 6;
score_t = 0;

score_list = ds_list_create();

is_hurt = false;
hurt_timer = 0;

game_over = false;
did_win = false;