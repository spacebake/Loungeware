image_speed = 0.3;
do_shoot = false;

words = 
[
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Primary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Secondary]
	],
	[
		[n8fl_penguin_blast_EProjectile.Primary,n8fl_penguin_blast_EProjectile.Secondary],
		[n8fl_penguin_blast_EProjectile.Secondary,n8fl_penguin_blast_EProjectile.Primary],
	]
];

_score_total = 0;
get_score_total = function() { return _score_total; }

phrase = ds_list_create();



var difficulties = [
	function(){
		// Difficulty 1. Give a stream of bombs to get the player used to holding down, but make 
		// them fail a few times by giving a word at the end
		microgame_set_timer_max(6);
		var word = choose(n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, choose(-1, n8fl_penguin_blast_EProjectile.Bomb));
		ds_list_add(phrase, word);
		ds_list_add(phrase, word);
		ds_list_add(phrase, word);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		
		// allow 0 miss
		//_score_total--;
	},
	function(){
		// Difficulty 2. Player should be used to holding by now and can take some heat
		microgame_set_timer_max(6);
		var phrasePart = choose(
			[n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary],
			[n8fl_penguin_blast_EProjectile.Secondary, n8fl_penguin_blast_EProjectile.Primary]
		);
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);	
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		
		// allow 1 miss
		_score_total--;
	},
	function(){
		// Difficulty 3. Begin patterns of mixed words back to back, requiring quick switching
		microgame_set_timer_max(7);
		var phrasePart = choose(
			[n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary],
			[n8fl_penguin_blast_EProjectile.Secondary, n8fl_penguin_blast_EProjectile.Primary]
		);
		
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		
		// allow 1 miss
		_score_total--;
	},
	function(){
		// Difficulty 4
		microgame_set_timer_max(7);
		var phrasePart = choose(
			[n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary],
			[n8fl_penguin_blast_EProjectile.Secondary, n8fl_penguin_blast_EProjectile.Primary]
		);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);	
		ds_list_add(phrase, phrasePart[1]);	
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, phrasePart[0]);	
		ds_list_add(phrase, -1);
		ds_list_add(phrase, phrasePart[1]);	
		ds_list_add(phrase, choose(n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary, n8fl_penguin_blast_EProjectile.Bomb));
	
		// allow 2 miss
		_score_total--;
		_score_total--;
	},
	function(){
		// Difficulty 5
		microgame_set_timer_max(7);
		var phrasePart = choose(
			[n8fl_penguin_blast_EProjectile.Primary, n8fl_penguin_blast_EProjectile.Secondary],
			[n8fl_penguin_blast_EProjectile.Secondary, n8fl_penguin_blast_EProjectile.Primary]
		);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[1]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, phrasePart[0]);
		ds_list_add(phrase, n8fl_penguin_blast_EProjectile.Bomb);

		// allow 2 miss
		_score_total--;
		_score_total--;
	}
];

difficulties[DIFFICULTY-1]();
var _i=0;
repeat(ds_list_size(phrase)){
	var _word = phrase[| _i];
	if(_word == n8fl_penguin_blast_EProjectile.Primary || _word == n8fl_penguin_blast_EProjectile.Secondary){
		_score_total++;	
	}
	++_i;
}

_tick = function(){
	var blast_player = n8fl_penguin_blast_player;
	if(!instance_exists(blast_player)){
		exit;	
	}

	if(ds_list_size(phrase) > 0){
		var last_do_shoot = do_shoot;
		do_shoot = image_index > 1;

		if(do_shoot != last_do_shoot){
			var index = phrase[| 0];
			ds_list_delete(phrase, 0);
			if(index >= 0){
				var proj = instance_create_depth(x, y, depth, n8fl_penguin_blast_projectile);
				proj.image_index = index;
				proj.dest_x = blast_player.x-20;
				proj.dest_y = blast_player.y;
			}
		}
	}else{
		image_index = 0;	
	}	
}