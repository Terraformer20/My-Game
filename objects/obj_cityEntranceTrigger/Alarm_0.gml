/// @description Change Room

// If haven't met himiko (trigger1) then play animation, otherwise normal loading zone
if (roomToGo != noone && nearbyPlayer != noone && nearbyPlayer != undefined) {
	if (global.triggers[0]) {
		if (isVertical) {
			transitionStart(roomToGo, xConstant, yConstant+nearbyPlayer.y, seq_base_out, seq_base_in);
		} else {
			transitionStart(roomToGo, xConstant+nearbyPlayer.x, yConstant, seq_base_out, seq_base_in);
		}
	} else {
		transitionStart(roomToGo, 163, 384, seq_base_out, seq_himiko_intro);
		global.triggers[0] = true; 
	}
}      