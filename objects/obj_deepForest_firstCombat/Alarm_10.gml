/// @description Post-textbox codes

switch (part) {
	// Move player into position
	case 0: {
		with (obj_player) {
			targetX = 478;
			targetY = 300;
			cutsceneSpeed = 3.5;
			giveControl = false;
			endingDir = 2;
			alarm[9] = 2;
		}
		alarm[1] = 140;
		part = 1;
	}; break;
	// Himiko looks around
	case 1: {
		obj_himiko.dir = 2;
		part = 2;
		alarm[3] = 30;
	}; break;
	// Himiko and Teal head down and approach slime
	case 2: {
		part = 3;
		with (obj_player) {
			targetX = 478;
			targetY = 569;
			cutsceneSpeed = 4;
			alarm[9] = 5;
		}
		with (obj_himiko) {
			targetX = 436;
			targetY = 569;
			cutsceneSpeed = 4;
			alarm[9] = 1;
		}
		alarm[7] = 80;
	}; break;
}