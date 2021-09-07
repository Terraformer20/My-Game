// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Create menu page with arbitrary number of inputs ["Name", type, entries]
function createMenuPage() {
	var arg;
	for (var i = 0; i < argument_count; i += 1) {
		arg[i] = argument[i];
	}
	
	var dsGridId = ds_grid_create(5, argument_count);
	
	for (var i = 0; i < argument_count; i += 1) {
		var array = arg[i];
		var arrayLength = array_length(arg[i]);
		
		for (var j = 0; j < arrayLength; j += 1) {
			dsGridId[# j, i] = array[j];
		}
	}
	
	return dsGridId;
}

function exitGame() {
	game_end();
}
 
function returnToMainMenu() {
	with (obj_menu) {
		menuOption[page] = 0;
	}
	global.pause = false;
	global.roomTarget = rm_start;
	transitionPlaceSequence(seq_base_out, camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])/2,
								camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])/2)
}

function changeBGMVolume(newVolume) {
	global.bgmVolume = newVolume;
}

function changeGUIVolume(newVolume) {
	global.uiVolume = newVolume;
}

function startGame() {
	global.timeSpent = 0;
	global.timeStarted = current_time;
	global.pause = false;
	obj_menu.page = 0;
	global.mainMenu = false;
	layer_set_target_room(rm_roomDay);
	transitionPlaceSequence(seq_room_intro, 352, 352);
	layer_reset_target_room();
	room = rm_roomDay;
	instance_create_layer(352, 303, "Instances", obj_player);
	
	global.characters = [new MC(), new Himiko(), new Trevor()];
	global.party = [global.characters[0]];
	
}

function saveGame(saveSlot) {
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
		array_push(_saveData, json_encode(global.inventory[0]));
		array_push(_saveData, json_encode(global.inventory[1]));
		array_push(_saveData, json_encode(global.inventory[2]));
		array_push(_saveData, json_encode(global.inventory[3]));
		array_push(_saveData, global.characters);
		array_push(_saveData, global.party);
		array_push(_saveData, global.triggers);
		
		global.timeSpent = current_time/1000 - global.timeStarted/1000 + global.timeSpent;
		array_push(_saveData, global.timeSpent);
	}

	// Turn all data into a JSON string and save it via buffer
	var _string = json_stringify(_saveData);
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	buffer_write(_buffer, buffer_string, _string);
	buffer_save(_buffer, "savedgame" + string(saveSlot) + ".save");
	buffer_delete(_buffer);
	
	
	// Generate the save info itself
	var _location = "Nowhere, how'd you do this???";
	switch (room) {
		case rm_city: _location = "Vaward Town"; break;
		case rm_deepForest_entrance: _location = "Deep Forest - Entrance"; break;
	}
	var _saveInfo = {
		playerName : global.playerName,
		// TODO FIX TIME
		playerTime : global.timeSpent,
		playerLevel : 1,
		location : _location,
	}
	variable_global_set("save"+string(saveSlot), _saveInfo);
	global.timeStarted = current_time;

	show_debug_message("Game saved! " + _string);
}

function loadGame(saveSlot) {
	// Chack if save exists
	if (file_exists("savedgame"+string(saveSlot)+".save")) {
		global.timeStarted = current_time;
		// erase current game state
		with (obj_player) instance_destroy();
	
		// Load save file
		var _buffer = buffer_load("savedgame"+string(saveSlot)+".save");
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
	
		// Use asset_get_index(_loadEntity.obj) to get the actual object that was saved
		layer_set_target_room(_loadData[0].savedRoom);
		transitionPlaceSequence(seq_dummy_in, 0, 0);
		layer_reset_target_room();
		room = _loadData[0].savedRoom
		var _player = instance_create_layer(0, 0, "Instances", obj_player);
		_player.x = _loadData[0].plrX;
		_player.y = _loadData[0].plrY;
	
		// Load talkedTo
		ds_map_destroy(global.talkedTo);
		global.talkedTo = json_decode(_loadData[1]);
		
		// Load inventory
		ds_map_destroy(global.inventory[0]);
		ds_map_destroy(global.inventory[1]);
		ds_map_destroy(global.inventory[2]);
		ds_map_destroy(global.inventory[3]);
		global.inventory[0] = json_decode(_loadData[2]);
		global.inventory[1] = json_decode(_loadData[3]);
		global.inventory[2] = json_decode(_loadData[4]);
		global.inventory[3] = json_decode(_loadData[5]);
		
		// Load characters and party
		global.characters = _loadData[6];
		global.party = _loadData[7];
		
		global.triggers = _loadData[8];
		global.timeSpent = _loadData[9];
		
		// Set default settings
		global.pause = false;
		global.playerControl = true;
		global.mainMenu = false;
		obj_menu.page = 0;
		for (var i = 0; i < array_length(obj_menu.menuPages); i += 1) {
			obj_menu.menuOption[i] = 0;
		}
	}
}