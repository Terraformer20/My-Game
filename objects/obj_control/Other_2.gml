/// @description Load settings and savefile information

if (file_exists("savedgame.save")) {
	// Load save file
	var _buffer = buffer_load("savedgame.save");
	var _string = buffer_read(_buffer, buffer_string);
	buffer_delete(_buffer);
	
	var _loadData = json_parse(_string);
	
	// Take the values from the saved settings and load them into the game
	var _settings = _loadData[0];
	global.bgmVolume = _settings[0];
	global.uiVolume = _settings[1];
	for (var i = 0; i < array_length(_settings); i += 1) {
		variable_global_set(_settings[i].name, _settings[i].value);
	}
	
	// Set the save variables
	for (var i = 0; i < 4; i += 1) {
		if (_loadData[i+1] != -1) {
			show_debug_message("Passed");
			variable_global_set("save"+string(i), _loadData[i+1])
		}
	}
}