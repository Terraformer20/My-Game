/// @description Choicebox stuff

var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);

if (global.triggers[0]) {
	createChoicebox(_camX, _camY+256, -10000, "Are you sure you want to leave?", ["Yes", "No"], [roomDayChange, instance_destroy]);
} else {
	createTextbox(_camX, _camY+266, -10000, "You should probably check your mail first.", noone);
}