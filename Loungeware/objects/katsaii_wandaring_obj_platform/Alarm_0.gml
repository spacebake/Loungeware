/// @desc Set culling faces.
var neighbour;
neighbour = instance_place(x - 1, y, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (neighbour.z <= z) {
        cullFlags |= CELL_LEFT;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= CELL_RIGHT;
    }
}
neighbour = instance_place(x, y - 1, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (neighbour.z <= z) {
        cullFlags |= CELL_TOP;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= CELL_BOTTOM;
    }
}
neighbour = instance_place(x + 1, y, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (neighbour.z <= z) {
        cullFlags |= CELL_RIGHT;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= CELL_LEFT;
    }
}
neighbour = instance_place(x, y + 1, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (neighbour.z <= z) {
        cullFlags |= CELL_BOTTOM;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= CELL_TOP;
    }
}