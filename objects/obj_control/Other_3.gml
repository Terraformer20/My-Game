/// @description Save settings and savefile information

// Make save array
var _saveData = array_create(0);

array_push(_saveData, global.settings);
array_push(_saveData, global.save0);
array_push(_saveData, global.save1);
array_push(_saveData, global.save2);
array_push(_saveData, global.save3);
show_debug_message(variable_global_get("save0"));

// Turn all data into a JSON string and save it via buffer
var _string = json_stringify(_saveData);
var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
buffer_write(_buffer, buffer_string, _string);
buffer_save(_buffer, "savedgame.save");
buffer_delete(_buffer);

show_debug_message("Game saved! " + _string);

/*
file_delete("savedgame.save");
file_delete("savedgame0.save");
file_delete("savedgame1.save");
file_delete("savedgame2.save");
file_delete("savedgame3.save");
*/

ds_map_destroy(global.talkedTo);
for (var i = 0; i < array_length(global.inventory); i += 1) {
	ds_map_destroy(global.inventory[i]);
}