/// @description Take away player control and move them back a bit

global.playerControl = false;
with (nearbyPlayer) {
	targetX = x;
	targetY = y + 32;
	cutsceneSpeed = 1.5;
	giveControl = true;
	alarm[9] = 2;
}