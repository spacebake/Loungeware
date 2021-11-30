// Defaults
depth = -y
image_speed = 0;

spin_accel = 1.5;
spin_amount = 0;
gun_height = 23;
shooting_allowed = true;


function approach(a, b, amount) {
    return (a + clamp(b - a, -amount, amount));
}
