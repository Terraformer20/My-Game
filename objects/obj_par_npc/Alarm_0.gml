/// @description Basic NPC code

// Change direction
dir = (obj_player.dir + 2) % 4
sprite_index = imageToShow[dir];

// Calculate camera locations
var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);

// If not talked to display first text, else display second text
show_debug_message(object_get_name(self.object_index));
if (oneText || !global.talkedTo[? object_get_name(self.object_index)]) {
	myTextbox = createNamedTextbox(_camX, _camY+266, -10000, textToShow, self, myName);  
	global.talkedTo[? object_get_name(self.object_index)] = true;
	show_debug_message(global.talkedTo[? object_get_name(self.object_index)]);
} else {
	myTextbox = createNamedTextbox(_camX, _camY+266, -10000, secondTextToShow, self, myName);  
}
