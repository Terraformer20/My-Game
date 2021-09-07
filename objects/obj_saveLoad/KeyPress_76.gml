/// @description Load Game

// Chack if save exists
if (file_exists("savedgame.save")) {

	// erase current game state
	with (obj_player) instance_destroy();
	
	// Load save file
	var _buffer = buffer_load("savedgame.save");
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
	
	ds_map_destroy(global.talkedTo);
	global.talkedTo = json_decode(_loadData[1]);
}