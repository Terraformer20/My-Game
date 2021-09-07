/// @description Variables and such

// Person variables
event_inherited();

// Variables
walkSpeed = 2.5;
nearbyInteractable = noone;

// Animation Setup
imageToShow[playerState.idle][0] = spr_teal_idle_right;
imageToShow[playerState.idle][1] = spr_teal_idle_up;
imageToShow[playerState.idle][2] = spr_teal_idle_left;
imageToShow[playerState.idle][3] = spr_teal_idle_down;

imageToShow[playerState.walking][0] = spr_teal_walk_right;
imageToShow[playerState.walking][1] = spr_teal_walk_up;
imageToShow[playerState.walking][2] = spr_teal_walk_left;
imageToShow[playerState.walking][3] = spr_teal_walk_down;