direction = image_angle;

// Acceleration
velocity = 0;
max_forward_speed = .8;
max_reverse_speed = -.6;
acceleration = .05;
fric = .02;

// Collisions
hsp_remaining = 0;
vsp_remaining = 0;

// Functions
function approach(a, b, amount) {
    return (a + clamp(b - a, -amount, amount));
}

// Sprite button blinky
button_subimg = 0;
alarm[0] = room_speed/2;
