/// @description Save Game

// Make save array
var _saveData = array_create(0);

// For every instance, create a struct and add it to the array
with (obj_control) {
	var _savePlayer = {
		obj : object_get_name(object_index),
		plrX : obj_player.x,
		plrY:  obj_player.y,
		savedRoom : room,
	}
	array_push(_saveData, _savePlayer);
	array_push(_saveData, json_encode(global.talkedTo));
}

// Turn all data into a JSON string and save it via buffer
var _string = json_stringify(_saveData);
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, "savedgame.save");
buffer_delete(_buffer);

show_debug_message("Game saved! " + _string);