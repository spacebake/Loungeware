alarm[0] = 1;
wandSprite = choose(
        katsaii_witchwanda_wand_basic,
        katsaii_witchwanda_wand_basic,
        katsaii_witchwanda_wand_basic,
        katsaii_witchwanda_wand_arrow);
wandOrder = choose(
        [0, 1, 2], [0, 2, 1],
        [1, 2, 0], [1, 0, 2],
        [2, 1, 0], [2, 0, 1]);
wandCurrent = 0;
selectionSpeed = 0.02;
selectionAmount = 0;
selectionID = 0;
failed = false;
win = false;
craftAnimation = -1;
craftSpeed = 0.075;
resultAudio = audio_emitter_create();
resultTimer = 0;
resultSpeed = 0.04;