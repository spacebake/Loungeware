//arrow control
wae_hog_myarrows.image_angle = image_angle
wae_hog_myarrows.visible = false
wae_hog_myarrows.x = x
wae_hog_myarrows.y = y
//rider control
wae_hog_myrider.image_angle = image_angle
wae_hog_myrider.x = x
wae_hog_myrider.y = y
wae_hog_myrider.image_index = 0
if instance_exists(wae_hog_exit)
{
	wae_hog_target_angle = point_direction(x,y,wae_hog_exit.x,wae_hog_exit.y)
}
//start animation
if wae_hog_state ==  "start animation"
{
	var _lerpfac = wae_hog_framecount/wae_hog_init_waitframes
	_lerpfac = sqrt(_lerpfac)
	x = lerp(wae_hog_initpos[0], wae_hog_startpos[0],_lerpfac)
	y = lerp(wae_hog_initpos[1], wae_hog_startpos[1],_lerpfac)
	wae_hog_speed = max(0, wae_hog_speed*0.95)
	if wae_hog_framecount > wae_hog_init_waitframes/2
	{wae_hog_angspeed += wae_hog_init_ang_accel}
	
	if wae_hog_framecount > wae_hog_init_waitframes
	{
		wae_hog_state = "running"
		sfx_play(yosi_EFT_snd_drive,0.2,false)
	}
	
}
//controls
else if wae_hog_state == "running"
{
	if KEY_LEFT
	{
		wae_hog_angspeed += 0.15
		wae_hog_myarrows.visible = true
		wae_hog_myarrows.image_xscale = -1
		wae_hog_myrider.image_xscale = 1
		wae_hog_myrider.image_index = 1
	}
	if KEY_RIGHT
	{
		wae_hog_angspeed -= 0.15
		wae_hog_myarrows.visible = true
		wae_hog_myarrows.image_xscale = 1
		wae_hog_myrider.image_xscale = -1
		wae_hog_myrider.image_index = 1
	}
	if abs(angle_difference(wae_hog_target_angle, wae_hog_dir)) < 30 and wae_hog_angspeed < 0.75
	{
		if wae_hog_myrider.image_index == 0
		{
			wae_hog_myrider.image_index = 2
		}
		wae_hog_speed += 0.05
	}
	else
	{
		if wae_hog_speed > 0.01 and wae_hog_myrider.image_index == 0
		{
			wae_hog_myrider.image_index = 3
		}
		wae_hog_speed -= 0.05
	}


}
else if wae_hog_state == "escape"
{
	wae_hog_angspeed = 0
	wae_hog_speed += 0.05
}
//movement
wae_hog_speed = min(wae_hog_maxspeed,max(0,wae_hog_speed))

//hog moves forward if rotation is low enough - maybe tie to difficulty?

if DIFFICULTY > 3
{
	wae_hog_angspeed += 0.1*random_range(-1,1)*(DIFFICULTY-3)
}




x += dcos(wae_hog_dir)*wae_hog_speed
y -= dsin(wae_hog_dir)*wae_hog_speed
if (x < wae_hog_padding or x > room_width -wae_hog_padding) and wae_hog_state != "escape"
{x = wae_hog_prevx
	wae_hog_speed = wae_hog_speed*0.7}
if (y < wae_hog_padding or y > room_height -wae_hog_padding) and wae_hog_state != "escape"
{y = wae_hog_prevy
	wae_hog_speed = wae_hog_speed*0.7}

wae_hog_angspeed = sign(wae_hog_angspeed) * min(5,abs(wae_hog_angspeed))
wae_hog_dir += wae_hog_angspeed
image_angle = wae_hog_dir - 90

if wae_hog_speed < 0.5 and abs(wae_hog_angspeed) < 1
{
	image_index = 3
}
if wae_hog_speed < 0.5 and abs(wae_hog_angspeed) >= 1
{
	if image_index > 5
	{
		image_index = 3
	}
}

//misc
wae_hog_framecount += 1

image_speed =wae_hog_speed*1 + abs(wae_hog_angspeed)/5
wae_hog_prevx = x
wae_hog_prevy = y