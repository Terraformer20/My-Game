// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function createTextbox(x, y, depth, textToShow, parent) {
	_myTextbox = instance_create_depth(x, y, depth, obj_textbox);
	_myTextbox.text = textToShow;
	_myTextbox.myParent = parent;
	return _myTextbox;
} 

function createNamedTextbox(x, y, depth, textToShow, parent, name) {
	_myTextbox = instance_create_depth(x, y, depth, obj_textbox);
	_myTextbox.text = textToShow;
	_myTextbox.myParent = parent;
	_myTextbox.names = name;
	return _myTextbox;
} 

function createAutoTextbox(x, y, depth, textToShow, parent) {
	_myTextbox = instance_create_depth(x, y, depth, obj_textbox);
	_myTextbox.text = textToShow;
	_myTextbox.myParent = parent;
	_myTextbox.auto = true;
	return _myTextbox;
} 

function createChoicebox(x, y, depth, textToShow, options, actionsToDo, parent) {
	_temp = instance_create_depth(x, y, depth, obj_choicebox);
	_temp.textToShow = textToShow;
	_temp.options = options;
	_temp.optionSelected = array_length(options)-1;
	_temp.actionsToDo = actionsToDo;
	_temp.myParent = parent;
	return _temp;
} 

function createDefaultTextbox(textToShow, parent) {
	var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
	var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
	return createTextbox(_camX, _camY+266, -10000, textToShow, parent); 
}

function createDefaultNamedTextbox (textToShow, parent, name) {
	var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
	var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
	return createNamedTextbox(_camX, _camY+266, -10000, textToShow, parent, name); 
}

function createDefaultChoicebox (textToShow, options, actionsToDo, parent) {
	var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
	var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
	return createChoicebox(_camX, _camY+256, -10000, textToShow, options, actionsToDo, parent);
}