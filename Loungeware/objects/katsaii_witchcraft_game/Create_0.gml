alarm[0] = 1;
wands = [
    katsaii_witchcraft_basic_parts,
    katsaii_witchcraft_fancy_parts,
    katsaii_witchcraft_gem_parts,
    katsaii_witchcraft_subway_parts,
];
wandsComplete = [
    katsaii_witchcraft_basic,
    katsaii_witchcraft_fancy,
    katsaii_witchcraft_gem,
    katsaii_witchcraft_subway,
];
var wandId = irandom(array_length(wands) - 1);
wandSprite = wands[wandId];
wandComplete = wandsComplete[wandId];
wandOrder = choose(
        [0, 1, 2], [0, 2, 1],
        [1, 2, 0], [1, 0, 2],
        [2, 1, 0], [2, 0, 1]);
wandCurrent = 0;
selectionSpeed = lerp(0.015, 0.03, (DIFFICULTY - 1) / 4);
selectionAmount = 0;
selectionID = 0;
failed = false;
win = false;
craftAnimation = -1;
craftSpeed = 0.075;
resultTimer = 0;
resultSpeed = 0.04;
alarm[2] = 1;