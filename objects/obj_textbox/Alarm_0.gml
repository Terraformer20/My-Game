/// @description Display Text Over Time

// Determine text display speed
if (auto) {
	var disSpd = 2;
} else {
	var disSpd = 4;
}
// Handle multiple textboxes needed and single textboxes needed
if (is_string(text)) {
	// Draw text over time
	if (count != string_length(text)) {
		count += 1;
		textToShow = string_copy(text, 0, count);
		if (!auto || (auto && count%2 == 0)) {
			playUIAudio(snd_textbox);
		}
		if (string_char_at(text, count) == ".") {
			alarm[0] = disSpd + 3;
		} else {
			alarm[0] = disSpd;
		}
	} else {
		myState = textboxState.idle;
	}
} else if (is_array(text)) {
	// Draw text over time
	if (count != string_length(text[textIndex])) {
		count += 1;
		textToShow = string_copy(text[textIndex], 0, count);
		if (!auto || (auto && count%2 == 0)) {
			playUIAudio(snd_textbox);
		}
		if (string_char_at(text[textIndex], count) == ".") {
			alarm[0] = disSpd + 3;
		} else {
			alarm[0] = disSpd;
		}
	} else {
		myState = textboxState.idle;
	}
}