 /// @description Change choices based on presses

if (options != undefined) {
	// Calculate where the arrow should be
	var _arrowX = sprite_width/((array_length(options)+1)*2)*(optionSelected*2+1) + 16;
	var _arrowY = y+sprite_height/4-2;
	
	// If the arrow doesn't exist yet then create it
	if (myArrow == noone || myArrow == undefined) {
		myArrow = instance_create_depth(_arrowX, _arrowY, depth-1, obj_arrow);
	}
	
	// Change between options
	if (keyboard_check_pressed(global.leftKey)) {
		optionSelected = max(0, optionSelected-1);
		playUIAudio(snd_choicebox_optionsChange);
		instance_destroy(myArrow);
		myArrow = noone;
	} else if (keyboard_check_pressed(global.rightKey)) {
		optionSelected = min(array_length(options)-1, optionSelected+1);
		playUIAudio(snd_choicebox_optionsChange);
		instance_destroy(myArrow);
		myArrow = noone;
	}

	// Select current option is pressed
	if (keyboard_check_pressed(global.acceptKey)) {
		playUIAudio(snd_choicebox_select);
		instance_destroy();
		actionsToDo[optionSelected]();
	}
}