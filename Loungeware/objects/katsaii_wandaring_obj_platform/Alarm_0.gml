/// @desc Set culling faces.
var neighbour_count = 0;
var neighbour;
neighbour = instance_place(x - 1, y, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (abs(neighbour.z - z) < 0.1) {
        neighbour_count += 1;
    }
    if (neighbour.z <= z) {
        cullFlags |= KATSAII_WANDARING_CELL_LEFT;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= KATSAII_WANDARING_CELL_RIGHT;
    }
}
neighbour = instance_place(x, y - 1, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (abs(neighbour.z - z) < 0.1) {
        neighbour_count += 1;
    }
    if (neighbour.z <= z) {
        cullFlags |= KATSAII_WANDARING_CELL_TOP;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= KATSAII_WANDARING_CELL_BOTTOM;
    }
}
neighbour = instance_place(x + 1, y, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (abs(neighbour.z - z) < 0.1) {
        neighbour_count += 1;
    }
    if (neighbour.z <= z) {
        cullFlags |= KATSAII_WANDARING_CELL_RIGHT;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= KATSAII_WANDARING_CELL_LEFT;
    }
}
neighbour = instance_place(x, y + 1, katsaii_wandaring_obj_platform);
if (neighbour) {
    if (abs(neighbour.z - z) < 0.1) {
        neighbour_count += 1;
    }
    if (neighbour.z <= z) {
        cullFlags |= KATSAII_WANDARING_CELL_BOTTOM;
    }
    if (neighbour.z >= z) {
        neighbour.cullFlags |= KATSAII_WANDARING_CELL_TOP;
    }
}
// spawn random foliage
if (random(1) < 0.25) {
    var foliage_state = [0, 0, 0, choose(0, 0, 0, 0, 1, 1, 2), choose(0, 0, 0, 1, 1, 2)];
    var row = round(x / KATSAII_WANDARING_CELL_SIZE);
    var col = round(y / KATSAII_WANDARING_CELL_SIZE);
    var off = -round(z / KATSAII_WANDARING_CELL_SIZE) - 1;
    switch (foliage_state[neighbour_count]) {
    case 0: // bushes
        katsaii_wandaring_instance_create_on_grid(row, col, katsaii_wandaring_obj_foliage, off).image_index = choose(0, 1);
        break;
    case 1: // candy
        katsaii_wandaring_instance_create_on_grid(row, col, katsaii_wandaring_obj_candy, off).image_index = choose(5, 6, 7, 8, 9);
        break;
    case 2: // trees
        katsaii_wandaring_instance_create_on_grid(row, col, katsaii_wandaring_obj_foliage, off).image_index = choose(2, 3, 4);
        break;
    }
}