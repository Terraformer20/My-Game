/// @description Setup

randomize();

global.playerControl = false;
obj_player.image_alpha = 0;
currPhase = battlePhase.init;
global.statTimer = {};
for (var i = 0; i < array_length(optionSelected); i += 1) {
	optionSelected[i] = 0;
}
global.deadUnits = [];