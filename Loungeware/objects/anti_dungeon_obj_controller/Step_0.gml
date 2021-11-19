

//not selecting an option
if battlestage!=1 {
	if desc!=desc_draw && textbox_open>=.9 {
	    desc_draw += string_char_at(desc,string_length(desc_draw)+1);  
	}	
}


//read text
if battlestage==0 {
	
	dosomething--
	
	if KEY_ANY_PRESSED || dosomething<=0 {
		if enemy_intro_y<0 { //first stage
			enemy_introtime = 0;
		}
		battlestage++
		
		while atk_ind == atk_last {
			atk_ind = irandom(array_length(attacks)-1);
		}
		atk_last = atk_ind;
		atk = attacks[atk_ind];
		
		optionflip = choose(0,1);
		desc = "["+atk[!optionflip]+"]  "+atk[optionflip];
		desc_draw = desc;
	}
}
//select attack
else if battlestage==1 {
	//switch options
	if KEY_LEFT_PRESSED || KEY_RIGHT_PRESSED || KEY_DOWN_PRESSED || KEY_UP_PRESSED {
		hitselect = !hitselect;	
		if hitselect {
			desc = "["+atk[!optionflip]+"]  "+atk[optionflip];
			desc_draw = desc;
		}
		else {
			desc = " "+atk[!optionflip]+"  ["+atk[optionflip]+"]";
			desc_draw = desc;
		}
	}
	if KEY_PRIMARY_PRESSED || KEY_SECONDARY_PRESSED {
		
		//right option
		if hitselect==optionflip {
			//hit effect
			var fx = instance_create_depth(0,0,0,anti_dungeon_obj_fx);
			with fx {
				while fnum == other.fx_last {
					fnum = irandom(array_length(effects)-1);
				}
				other.fx_last = fnum;
				setup();
			}
		
		
			desc = attacksounds[irandom(array_length(attacksounds)-1)];
			desc_draw = "";
		
			enemyhealth -= damage;
		}
		//wrong option
		else {
			desc = failsounds[irandom(array_length(failsounds)-1)];
			desc_draw = "";
		}
		
		
		hitselect = 1;
		if enemyhealth<=0 {
			battlestage++
			enemy_introtime = 15;
			microgame_win();
		}
		else {
			battlestage = 0;
			dosomething = dosomething_between;
		}
	}
}


///fx
enemyshake = lerp(enemyshake,0,.2);



//enemy and ui slide in/out
if battlestage < 2 {
	
	if enemy_introtime > 0 {
	    enemy_introtime--    
	}
	else {
	    enemy_intro_y = lerp(enemy_intro_y,0,.15);
	}
	
	textbox_open = lerp(textbox_open,1,.1);
	
}
else {
	
	if !instance_exists(anti_dungeon_obj_fx) {
		if enemy_introtime > 0 {
			enemy_intro_y = lerp(enemy_intro_y,70,.15);
		}
		else {
			 enemy_introtime--	
		}
		
		textbox_open = lerp(textbox_open,0,.1);
		
	}
	
}


///win sound
if bogos!="binted" && !audio_is_playing(musicid) {
	if MICROGAME_WON {
		sfx_play(anti_dungeon_snd_win,1,false);
	}
	else {
		sfx_play(anti_dungeon_snd_lose,1,false);
	}
	bogos = "binted";
}