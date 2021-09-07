/// @description Play Music/Ambience based on room

// Music based on room
audio_stop_all();
switch room {
	case rm_roomDay: {
		playBGMAudio(snd_room_ambience);
	}; break;
	case rm_start: {
		global.mainMenu = true;
		obj_menu.page = 2;
		global.pause = true;
		if (instance_exists(obj_player)) instance_destroy(obj_player);
	}; break;
}