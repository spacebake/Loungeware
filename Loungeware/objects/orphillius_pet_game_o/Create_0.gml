rmw=480
rmh=320

drawscale=4

//game_phases:
//	egg falling, cracks at floor
//	creature care, player must perform tasks depending on creature's state
//	game finish, final animation for win/lose
game_phase=0

floory=rmh-12*drawscale	//y pos of "floor" of game

pet=noone
request=noone
request_angle=1
request_wiggle_dir=1

action_timer=20		//time for a new action to be performed
action_c=0			//counter for new action to be performed

menu_options=["Feed", "Clean", "Play"]
menu_current=0

anim_c=0

switch DIFFICULTY{
	case 0:
		success_req=2
	break;
	case 1:
		success_req=3
	break;
	case 2:
		success_req=4
	break;
	case 3:
		success_req=5
	break;
	case 4:
		success_req=6
	break;
	case 5:
		success_req=7
	break;
}

successes=0