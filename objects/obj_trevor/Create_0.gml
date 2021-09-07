/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

imageToShow[playerState.idle][0] = spr_trevor_idle_right;
imageToShow[playerState.idle][1] = spr_trevor_idle_up;
imageToShow[playerState.idle][2] = spr_trevor_idle_left;
imageToShow[playerState.idle][3] = spr_trevor_idle_down;

imageToShow[playerState.walking][0] = spr_trevor_walk_right;
imageToShow[playerState.walking][1] = spr_trevor_walk_up;
imageToShow[playerState.walking][2] = spr_trevor_walk_left;
imageToShow[playerState.walking][3] = spr_trevor_walk_down;