/// @description Hop Down

if (y < startY) {
	y += 4;
	alarm[5] = 1;
} else {
	y = startY;
	numberOfHops -= 1;
	alarm[6] = 1;
}