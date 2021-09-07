/// @description Auto textbox handling
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