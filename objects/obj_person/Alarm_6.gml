/// @description Hop Up

if (numberOfHops == 0) {
	numberOfHops = -1;
	midHop = false;
	exit;
}
if (!midHop) {
	midHop = true;
	startY = y;
	if (numberOfHops == -1) {
		numberOfHops = 1;
	}
	// TODO Play Hop Sound
}
if (y > startY - 16) {
	y -= 4;
	alarm[6] = 1;
} else {
	alarm[5] = 1;
}
