/// @description Trigger if nearbyPlayer

nearbyPlayer = collision_rectangle(x-sprite_width/2, y-sprite_height/2, x+sprite_width/2, y+ sprite_height/2, obj_player, true, true);
if (nearbyPlayer != undefined && nearbyPlayer != noone) {
	if (myState == triggerState.idle) {
		myState = triggerState.triggered;
		alarm[0] = 2;
		// Show debug message
		show_debug_message("Triggered");
	}
} else {
	myState = triggerState.idle;
}