x += vx;
y += vy;
vy += grav;

vx *= 0.99;

image_alpha -= 0.02;

image_angle += angle_speed;