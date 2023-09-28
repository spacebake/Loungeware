hit--;
switch(phase){
	
	case 0:
		x = room_width * .5;
		y = lerp(y, ( room_height * .5 ) - ( 64 + (32*dsin(current_time/10))), 0.1);
	break;
	case 1:
		var xx = room_width * .5;
		var yy = room_height* .5;
		x = lerp(x, xx + lengthdir_x(room_height*.3, current_time/15), 0.01);
		y = lerp(y, yy + lengthdir_y(room_height*.3, current_time/15), 0.01);
	break;
	case 2:
		y = lerp(y, room_height * .25, 0.1);
		x = lerp(x, (room_width * .5) + dcos(current_time/10) * room_width * .25, 0.1);
	break;
	case 3:
		angle_move	+= 0.1 * (!giz.game.is_won ? -1 : 1);
		angle		+= angle_move;
		y			+= angle_move;
	break;
	
}
