/// @description Move towards target point

if (cutsceneSpeed = 0) {
	exit;
} else if (point_distance(x, y, targetX, targetY) > cutsceneSpeed) {
    move_towards_point(targetX, targetY, cutsceneSpeed);
} else {
	x = targetX;
	y = targetY;
	speed = 0;
	cutsceneSpeed = 0;
}