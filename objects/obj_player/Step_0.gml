/// @description Player code

if (global.playerControl && !global.pause) {
	// Get movement input
	walkUp = keyboard_check(global.upKey);
	walkDown = keyboard_check(global.downKey);
	walkLeft = keyboard_check(global.leftKey);
	walkRight = keyboard_check(global.rightKey);
	fastWalk = keyboard_check(global.sprintKey);

	// Calculate movement
	vx = (walkRight - walkLeft) * walkSpeed;
	vy = (walkDown - walkUp) * walkSpeed;

	// Pressing shift makes you walk slower
	if (fastWalk != 0) {
		vx = vx * 2;
		vy = vy * 2;
	}

	// Handle collisions and movement
	if (vx != 0 || vy != 0) {
		if (!collision_rectangle(x+sign(vx)*16, y-5, x+sign(vx)*16, y+5, obj_par_environment, true, true)) {
			x += vx;
		}
		if (!collision_rectangle(x-10, y+sign(vy)*8, x+10, y+sign(vy)*16, obj_par_environment, true, true)) {
			y += vy;
		}
		// Change Walking Sprite based on direction
		if (vx > 0) {
			dir = 0;
		}
		if (vx < 0) {
			dir = 2;
		}
		if (vy > 0) {
			dir = 3;
		}
		if (vy < 0) {
			dir = 1;
		}
		myState = playerState.walking;
	} else {
		myState = playerState.idle;
	}

	// Locate Nearby Interatable Code
	switch dir {
		case 0: {
			nearbyInteractable = collision_rectangle(x, y, x + 17, y, obj_par_interactable, true, true);
		}; break;
		case 1: {
			nearbyInteractable = collision_rectangle(x, y, x, y - 17, obj_par_interactable, true, true);
		}; break;
		case 2: {
			nearbyInteractable = collision_rectangle(x, y, x - 17, y, obj_par_interactable, true, true);
		}; break;
		case 3: {
			nearbyInteractable = collision_rectangle(x, y, x, y + 17, obj_par_interactable, true, true);
		}; break;
	}
	if (nearbyInteractable != noone && nearbyInteractable != undefined) {
		//show_debug_message("Found interactable");
	} else {
		//show_debug_message("Not facing interactable");
	}
	
	// Activate interactable
	if (keyboard_check_pressed(global.acceptKey)) {
		if (global.playerControl && !global.interactableActive) {
			if (nearbyInteractable != noone && nearbyInteractable != undefined) {
				nearbyInteractable.myState = interactableState.active;
			}
		}
	}
} else if (cutsceneSpeed == 0) {
	myState = playerState.idle;
}

event_inherited();