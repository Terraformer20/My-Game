/// @description Post-textbox code

switch(phase) {
	case 0: {
		giveItem(global.itemsDB.key.manual, 1, self);
		phase = 1;
	}; break;
	case 1: {
		createDefaultNamedTextbox(["Ok, let's head deeper then and knock some sense into Trevor"], self, ["Himiko"]);
		phase = 2;
	}; break;
	case 2: {
		with(obj_himiko) {
			targetX = obj_player.x;
			targetY = obj_player.y;
			cutsceneSpeed = 2;
			alarm[8] = 1;
		}
		alarm[0] = 10;
	}; break;
}