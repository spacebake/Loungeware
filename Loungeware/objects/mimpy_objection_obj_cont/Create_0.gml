cam = view_camera[0];

tm = new mimpy_tween_manager();
tween_cam_x = function(_val) {
	var cam_y = camera_get_view_y(cam);
	camera_set_view_pos(cam, _val, cam_y);
}
tween_edge_x = function(_val) {
	layer_sprite_x(laroldSprite, edgeX + _val);
	
	if (layer_sprite_exists("Sprites", speechSprite))
		layer_sprite_x(speechSprite, speechX + _val);
	if (layer_sprite_exists("Clue", clueSprite))
		layer_sprite_x(clueSprite, clueX + _val);
	
}
tween_objection = function(_val) {
	layer_sprite_x(objectionSprite, _val);
}


stop_objection = function() {
	layer_sprite_destroy(objectionSprite);
}

/* Select clue to quiz about */
question = choose(
	{
		clue: mimpy_objection_spr_clue_mouse,
		evidence: mimpy_objection_spr_evidence_mouse,
		answer: 0
	},
	{
		clue: mimpy_objection_spr_clue_bunny,
		evidence: mimpy_objection_spr_evidence_mouse,
		answer: 1
	},
	{
		clue: mimpy_objection_spr_clue_nine,
		evidence: mimpy_objection_spr_evidence_nine,
		answer: 1
	},
	{
		clue: mimpy_objection_spr_clue_seven,
		evidence: mimpy_objection_spr_evidence_nine,
		answer: 2
	}
);

objectionSprite = -1;
bakuSprite = layer_sprite_get_id("Sprites", "mimpy_objection_graphic_baku");
laroldSprite = layer_sprite_get_id("Sprites", "mimpy_objection_graphic_larold");
speechSprite = layer_sprite_get_id("Sprites", "mimpy_objection_graphic_speech");
clueSprite = layer_sprite_get_id("Clue", "mimpy_objection_graphic_clue");
layer_sprite_change(clueSprite, question.clue);

edgeX = layer_sprite_get_x(laroldSprite);
speechX = layer_sprite_get_x(speechSprite);
clueX = layer_sprite_get_x(clueSprite);
speechY = layer_sprite_get_y(speechSprite);
clueY = layer_sprite_get_y(clueSprite);
time = 0;

sel_snd = -1;

/* Create evidence */
evidence = [];


selection = 0;
presenting = true;

tm.add(new mimpy_tween(128, 0, 60, tween_edge_x, "BounceOut",
	function() {
		var list = ds_list_create();
		ds_list_add(list, 0, 1, 2);
		ds_list_shuffle(list);

		for (var i = 0; i < 3; i++) {
			var inst = instance_create_layer(VIEW_X + (i + 1) * VIEW_W / 4, room_height + 64, "Evidence", mimpy_objection_obj_evidence);
			inst.sprite = question.evidence;
			inst.index = list[| i];
			inst.tm.add(new mimpy_tween_wait(i * 15));
			inst.tm.add(new mimpy_tween(inst.y, room_height - 64, game_get_speed(gamespeed_fps), inst.tween_y, "BackOut"));
			array_push(evidence, inst);
		}

		ds_list_destroy(list);
		presenting = false;
	}
));

confetti = [];