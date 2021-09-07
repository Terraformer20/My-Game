/// @description Base Person Variables

// Cutscene variables
targetX = 0;
targetY = 0;
cutsceneSpeed = 0;
giveControl = false;
endingDir = -1;
midHop = false;
startY = 0;
numberOfHops = -1;

myState = playerState.idle;

// Basic images
imageToShow[playerState.idle][0] = sprite_index;
imageToShow[playerState.idle][1] = sprite_index;
imageToShow[playerState.idle][2] = sprite_index;
imageToShow[playerState.idle][3] = sprite_index;

imageToShow[playerState.walking][0] = sprite_index;
imageToShow[playerState.walking][1] = sprite_index;
imageToShow[playerState.walking][2] = sprite_index;
imageToShow[playerState.walking][3] = sprite_index;