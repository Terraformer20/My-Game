/// @description Basic Interactable code

var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
myTextbox = createTextbox(_camX, _camY+266, -10000, textToShow, self); 