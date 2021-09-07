 // Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Textbox for desk option "Work"
function roomDayDeskWork() {
	instance_destroy();
	createTextbox(room_width/2, room_height-86, -10000,
				"Do you really think you'll get something done today?", instance_find(obj_room_desk, 0));
}

// Textbox for desk option "Check Mail" different before and after trigger
function roomDayDeskMail() {
	instance_destroy();
	if (global.triggers[0]) {
		createTextbox(room_width/2, room_height-86, -10000,
				"You should get some water from outside.", instance_find(obj_room_desk, 0));
	} else {
		createTextbox(room_width/2, room_height-86, -10000,
					["From Himiko: Hey " + global.playerName + ", long time no see.",
					"Trevor thought you might be getting a little lonely so he asked me to invite you to a \"post-college reunion.\"",
					"Sorry for not really keeping up, but I didn't want to bother you since you said you were busy working on something last time.",
					"But yeah, I also thought it would be nice to catch up, and it would just be the three of us like before.",
					"Just let me know if you plan on going or not, it's gonna be at that old burger joint we used to go to in two days for dinner.",
					"...",
					"Your throat goes dry. You should get some water from outside."],
					instance_find(obj_room_desk, 0));
		global.triggers[0] = true;
	}
}
	
// Change room test
function roomDayChange() {
	instance_destroy();
	global.triggers[0] = false;
	transitionStart(rm_forestRoomEntrance, 415, 350, seq_room_exit_out, seq_room_exit_in);
}
