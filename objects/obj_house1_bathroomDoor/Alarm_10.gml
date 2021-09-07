/// @description Insert description here
// You can write your code in this editor

switch (phase) {
	case 9: giveItem(global.itemsDB.accessories.toiletPaper); break;
	default: {
		global.playerControl = true;
	} break;
}
phase = min(phase + 1, 10);
myState = interactableState.inactive;
global.interactableActive = false;