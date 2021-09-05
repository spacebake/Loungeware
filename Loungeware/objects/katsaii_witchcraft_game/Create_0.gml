alarm[0] = 1;
wandSprite = choose(
        katsaii_witchcraft_wand_arrow,
        katsaii_witchcraft_wand_basic,
        katsaii_witchcraft_wand_other,
        katsaii_witchcraft_wand_sandwhich);
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