/// @description Insert description here
// You can write your code in this editor
wae_hog_framecount = 0
wae_hog_speed = 1
wae_hog_angspeed = 0// random_range(5,10)*(2*irandom_range(0,1)-1)
wae_hog_target_angle = 0
wae_hog_init_ang_accel =  0.01*random_range(5,10)*(2*irandom_range(0,1)-1)*(1+DIFFICULTY/3)
wae_hog_init_waitframes = 75

wae_hog_state = "start animation"

wae_hog_myrider = instance_create_depth(x,y,depth-10,wae_hog_rider)
wae_hog_myarrows = instance_create_depth(x,y,depth-2,wae_hog_arrows)
wae_hog_myarrows.visible = false

wae_hog_padding = 10


wae_hog_startpos = [room_width/2, room_height/2]
wae_hog_init_dist = min(room_width*0.3,room_height*0.3)
wae_hog_init_angle = random_range(0,360)
wae_hog_initpos = [wae_hog_init_dist*dcos(wae_hog_init_angle) + room_width/2,-wae_hog_init_dist*dsin(wae_hog_init_angle) + room_height/2]
x = wae_hog_initpos[0]
y = wae_hog_initpos[0]
wae_hog_dir = wae_hog_init_angle + 180

wae_hog_prevx = x
wae_hog_prevy = y


wae_hog_minspeed = 0.5 + DIFFICULTY/3
wae_hog_maxspeed = 3 + DIFFICULTY/3

sfx_play(wae_hog_squealing,0.7,1)