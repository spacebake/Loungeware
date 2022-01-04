function get_state() {
    static state = 1;
    state = !state;
    return state;
}

image_yscale = get_state() ? -1 : 1;
hspeed = image_yscale * random_range(8, 16);
vspeed = -random_range(10, 20);
gravity = 1;