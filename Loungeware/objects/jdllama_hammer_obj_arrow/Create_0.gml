image_speed = random_range(-1, 1);
if (image_speed == 0) {
  image_speed = choose(-.5, .5);
}
image_index = irandom(image_number - 1);