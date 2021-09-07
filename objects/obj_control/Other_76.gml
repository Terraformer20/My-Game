 /// @description Handle messages from sequences

switch event_data[? "message"] {
	case "playerInvisible": {
		obj_player.image_alpha = 0;
	}; break;
	case "playerVisible": {
		obj_player.image_alpha = 255;
	}; break;
	case "himikoIntro": {
		var _himiko = instance_create_layer(234, 384, "Instances", obj_himiko);
		_himiko.dir = 2;
		
		var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
		var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
	
		myTextbox = createNamedTextbox(_camX, _camY+266, -10000, 
			["There you are "+global.playerName+". I was looking all over town for you.",
			"...",
			"Quiet as always I see. Anyways, I need your help. Trevor's being an idiot, as usual.",
			"Some evil organization invited him to join them, and he just went with the flow and joined.",
			"You know him, he won't even listen to me. Can you try to see if you can talk some sense into him?",
			"*nods*",
			"Thanks. I think he's around town somewhere. I'd bet he's probably loitering around the store with them right now.",
			"Let's go."], self, 
			["Himiko", global.playerName, "Himiko", "Himiko", "Himiko", global.playerName, "Himiko", "Himiko"]);  
	}; break;
}