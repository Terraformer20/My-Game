/// @description Textbox internal code

// Next textbox or close based on if you press the key
if (keyboard_check_pressed(global.acceptKey) && !auto) {
	switch myState {
		case textboxState.writing: {
			// Handle array vs. string indexing
			if (is_string(text)) {
				count = string_length(text);
				textToShow = text;
			} else if (is_array(text)) {
				count = string_length(text[textIndex]);
				textToShow = text[textIndex];
			}
		}; break;
		case textboxState.idle: {
			// If string or if no more text then delete
			if (is_string(text) || textIndex == array_length(text)-1) {
				instance_destroy();
				if (myParent != noone && myParent != undefined) {
					with (myParent) {
						alarm[10] = 2
					}
				}
			} else if (is_array(text)) {
				count = 0;
				textIndex += 1;
				textToShow = "";
				alarm[0] = 2;
				myState = textboxState.writing;
			}
		}; break;
	}
} else if (auto) {
	if (myState == textboxState.idle) {
		myState = textboxState.wait;
		alarm[1] = 30;
	}
}

// Set the name of the textbox if applicable
if (names != undefined) {
	if (is_string(names)) {
		nameToShow = names;
	} else if (is_array(names)) {
		nameToShow = names[textIndex];
	}
}