 /// @description Change Room

if (roomToGo != noone && nearbyPlayer != noone && nearbyPlayer != undefined) { 
	if (dirToSet != -1) {
		nearbyPlayer.endingDir = dirToSet;
	}
	if (exactPos) {
		transitionStart(roomToGo, xConstant, yConstant, seq_base_out, seq_base_in);
	} else if (isVertical) {
		transitionStart(roomToGo, xConstant, yConstant+nearbyPlayer.y, seq_base_out, seq_base_in);
	} else {
		transitionStart(roomToGo, xConstant+nearbyPlayer.x, yConstant, seq_base_out, seq_base_in);
	}
} 