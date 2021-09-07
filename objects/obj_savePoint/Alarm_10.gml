/// @description Reset All Things and Open Load Save Menu

myState = interactableState.inactive;
global.interactableActive = false;
with (obj_menu) {
	page = 3;
}
global.pause = true;