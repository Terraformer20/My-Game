// Move person from their current position to target position (Horizontally then vertically)
function movePersonToXY(_person, _targetX, _targetY, _speed) {
	with (_person) {
		targetX = _targetX;
		targetY = _targetY;
		cutsceneSpeed = _speed;
		alarm[9] = 1;
	}
}

// Move person from their current position to target position (Vertically then horizontally)
function movePersonToYX(_person, _targetX, _targetY, _speed) {
	with (_person) {
		targetX = _targetX;
		targetY = _targetY;
		cutsceneSpeed = _speed;
		alarm[8] = 1;
	}
}

function changePersonFacing(_person, _dir) {
	_person.dir = _dir;
}

function hop(person) {
	with(person) {
		alarm[6] = 1;
	}
}