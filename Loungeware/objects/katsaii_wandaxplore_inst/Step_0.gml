/// @desc Update position.
var pt = katsaii_wandaxplore_transform_point(xstart, ystart);
x = pt[0];
y = pt[1];
depth = -y;
if (background) {
    depth += 1000;
}