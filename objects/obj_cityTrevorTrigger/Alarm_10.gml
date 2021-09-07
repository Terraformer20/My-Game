/// @description After textbox stuff

// Move player into hiding position and initial dialogue
if (part == 0) {
	with (obj_player) {
		giveControl = false;
		targetX = 478;
		targetY = 655;
		cutsceneSpeed = 4;
		endingDir = 0;
		alarm[9] = 2;
	}
	alarm[9] = 135;
	part = 1;
} // Change camera and pan up to Trevor and Skullcrusher talking
else if (part == 1) {
	obj_himiko.dir = 0;
	// Create a cameraFocus instance
	var _camFocus = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_cameraFocus);
	
	// Switch camera to cameraFocus centered one
	oldCamera = view_camera;
	myCamera = camera_create_view(obj_player.x, obj_player.y, 704, 704, 0, obj_cameraFocus, -1, -1, 352, 352);
	view_set_camera(view_current, myCamera);
	show_debug_message("created");
	
	with (_camFocus) {
		targetX = 670;
		targetY = 495;
		cutsceneSpeed = 2;
	}
	alarm[7] = 135;
	part = 2;
} // Trevor looks down notices gang and talks
else if (part == 2) {
	obj_trevor.dir = 3;
	obj_trevor.alarm[6] = 2;
	alarm[6] = 60;
	part = 3;
} // Move Himiko and Teal into position
else if (part == 3) {
	obj_skullcrusher.dir = 3;
	with (obj_himiko) {
		targetX = 704;
		targeyY = y;
		cutsceneSpeed = 2;
		endingDir = 1;
		alarm[8] = 2;
	}
	with (obj_player) {
		targetX = 640;
		targeyY = y;
		cutsceneSpeed = 2;
		endingDir = 1;
		alarm[8] = 2;
	}
	alarm[5] = 120;
	part = 4;
} // Trevor & co. rush past gang and dissapear
else if (part == 4) {
	with (obj_trevor) {
		targetY = 1000;
		targetX = x;
		cutsceneSpeed = 6;
		alarm[8] = 2;
	}
	with (obj_skullcrusher) {
		targetY = 1000;
		targetX = x;
		cutsceneSpeed = 6;
		alarm[8] = 2;
	}
	with (obj_player) {
		targetY = y;
		targetX = x-32;
		cutsceneSpeed = 10;
		alarm[7] = 30;
	}
	with (obj_himiko) {
		targetY = y;
		targetX = x+40;
		cutsceneSpeed = 10;
		alarm[7] = 30;
	}
	part = 5;
	alarm[4] = 120;
} // Move himiko on top of teal to be deleted
else if (part == 5) {
	with (obj_himiko) {
		targetX = obj_player.x;
		targetY = obj_player.y;
		endingDir = 0;
		cutsceneSpeed = 2;
		alarm[8] = 2;
	}
	alarm[2] = 30;
}