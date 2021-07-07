
if(is_miss || is_success){
	vy += grav;
	x += vx;
	y += vy;
	if(is_success){
		image_alpha -= 0.1;
	}
	
	var max_y = 150;
	
	
	y = min(max_y, y);
	if(y == max_y){
		vx *= 0.4;
	}
	
	if(is_miss){
		x = min(175,x);
	}
	exit;	
}

time+=1/60;

var t = time / duration;

if(t < 1){
	x = lerp(start_x, dest_x, t);
	y = lerp(start_y, dest_y, t) - sin(t * 4) * max_height;
} else {
	x += 1;
	y += 1;
}

image_angle += 5;