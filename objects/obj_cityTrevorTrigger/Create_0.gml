/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

part = 0;
oldCamera = noone;
myCamera = noone;

if (!global.triggers[1]) {
	var _trevor = instance_create_layer(640, 416, "Instances", obj_trevor);
	_trevor.dir = 0;
	var _skullcrusher = instance_create_layer(704, 416, "Instances", obj_skullcrusher);
	_skullcrusher.dir = 2;
}