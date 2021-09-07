// Place squences in the room
function transitionPlaceSequence(_type, _x, _y) {
	if (layer_exists("transition")) layer_destroy("transition");
	var _lay = layer_create(-12000, "transition");
	layer_sequence_create(_lay, _x,_y, _type);
}

// Called when you want to go from one room to another using combination of in/out sequences
function transitionStart(_roomTarget, _x, _y, _typeOut, _typeIn) {
	if (!global.midTransition) {
		// Set variables for transition/room change
		global.playerControl = false;
		global.midTransition = true;
		global.roomTarget = _roomTarget;
		global.xTarget = _x;
		global.yTarget = _y;
		
		// Place transition sequences
		transitionPlaceSequence(_typeOut, camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])/2,
								camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])/2);
		layer_set_target_room(_roomTarget);
		transitionPlaceSequence(_typeIn, median(352, global.xTarget, global.roomDim[_roomTarget][0]-352), median(352, global.yTarget, global.roomDim[_roomTarget][1]-352));
		layer_reset_target_room();
		return true; 
	} else {
		return false;
	}
}

// Called when "in" transitions finish
function transitionFinished() {
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	global.playerControl = true;
}

// Change rooms / called when "out" transitions finished
function roomChange() {
	room_goto(global.roomTarget);
	obj_player.x = global.xTarget;
	obj_player.y = global.yTarget;
	if (obj_player.endingDir != -1) {
		obj_player.dir = obj_player.endingDir;
		obj_player.endingDir = -1;
	}
}

// Called when "in" special transitions finish so playercontrol is not restored
function transitionSpecialFinished() {
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
}

function playTransitionSequence(_type, _x, _y) {
	global.midTransition = true;
	transitionPlaceSequence(_type, _x, _y);
}

function himikoIntroEnd() {
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	createDefaultTextbox("Himiko joined the party.", undefined);
	array_push(global.party, global.characters[1]);
}

function battleFinish() {
	with(obj_control) {
		alarm[11] = 1;
	}
	global.midTransition = false;
}