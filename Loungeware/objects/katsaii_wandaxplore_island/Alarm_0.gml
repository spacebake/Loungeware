/// @desc Add foliage.
var density = 0.1;
var pad = 10;
repeat (width * height / 64 * density) {
    instance_create_layer(
            random_range(xstart - width / 2 + pad, xstart + width / 2 - pad),
            random_range(ystart - height / 2 + pad, ystart + height / 2 - pad),
            layer, katsaii_wandaxplore_island_foliage);
}