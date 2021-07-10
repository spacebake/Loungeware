if (failed || win) {
    exit;
}
var next_selection = selectionAmount + selectionSpeed;
if (next_selection > 1 || next_selection < 0 || KEY_SECONDARY_PRESSED) {
    selectionSpeed *= -1;
} else {
    selectionAmount = next_selection;
}
if (selectionAmount < 1 / 3) {
    selectionID = 0;
} else if (selectionAmount > 2 / 3) {
    selectionID = 2;
} else {
    selectionID = 1;
}
if (KEY_PRIMARY_PRESSED) {
    if (wandCurrent == wandOrder[selectionID]) {
        wandCurrent += 1;
        if (wandCurrent > 2) {
            microgame_win();
            win = true;
        } else {
            selectionAmount = random(1);
            show_debug_message(selectionAmount);
            selectionSpeed *= choose(1, -1);
        }
    } else {
        microgame_fail();
        failed = true;
    }
}