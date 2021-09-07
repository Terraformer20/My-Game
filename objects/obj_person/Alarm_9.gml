/// @description Move around in a cutscene (Horizontally then vertically)

if (targetX > x + cutsceneSpeed) {
	dir = 0;
	myState = playerState.walking;
	x = x + cutsceneSpeed;
	alarm[9] = 1;
	exit;
} else if (targetX < x - cutsceneSpeed) {
	dir = 2;
	myState = playerState.walking;
	x = x - cutsceneSpeed;
	alarm[9] = 1;
	exit;
}
x = targetX;

if (targetY > y + cutsceneSpeed) {
	dir = 3;
	myState = playerState.walking;
	y = y + cutsceneSpeed;
	alarm[9] = 1;
	exit;
} else if (targetY < y - cutsceneSpeed) {
	dir = 1;
	myState = playerState.walking;
	y = y - cutsceneSpeed;
	alarm[9] = 1;
	exit;
}
y = targetY;
cutsceneSpeed = 0;
myState = playerState.idle;

if (giveControl) {
	global.playerControl = true;
}
if (endingDir != -1) {
	dir = endingDir;
	endingDir = -1;
}