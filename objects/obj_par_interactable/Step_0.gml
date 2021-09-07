/// @description Interactable code for textboxes

// Handle textboxes
switch myState {
	// If you were just inactive then activate alarm[0]
	case interactableState.active: {
		if (global.playerControl && !global.interactableActive) {
			alarm[0] = 2;
			global.interactableActive = true;
		}
	}; break
}