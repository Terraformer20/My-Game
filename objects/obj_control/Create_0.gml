  /// @description Creation stuff

// Main Menu variables
global.mainMenu = false;
optionSelected = 0;
myCamera = noone;
oldCamera = noone;

// NPC TalkedTo Information
global.talkedTo = ds_map_create();

// Base Variables
global.playerControl = true;
global.interactableActive = false;
global.playerName = "Teal";
global.pause = false;
global.timeStarted = 0;

// Transition variables
global.midTransition = false;
global.roomTarget = -1;
global.xTarget = 0;
global.yTarget = 0;
 
// Volume Variables
global.bgmVolume = 0.3;
global.uiVolume = 0.3;

// Control Variables
global.leftKey = vk_left;
global.rightKey = vk_right;
global.upKey = vk_up;
global.downKey = vk_down;
global.acceptKey = ord("Z");
global.exitKey = ord("X");
global.sprintKey = vk_shift;

// Save variables
global.save0 = -1;
global.save1 = -1;
global.save2 = -1;
global.save3 = -1;

// Inventory variables 
consumables = ds_map_create();
consumables[? global.itemsDB.consumables.potion] = 1;
consumables[? global.itemsDB.consumables.potion2] = 1;
weapons = ds_map_create();
weapons[? global.itemsDB.weapons.sword1] = 3;
weapons[? global.itemsDB.weapons.sword2] = 1;
accessories = ds_map_create();
keyItems = ds_map_create();
global.inventory = [consumables, weapons, accessories, keyItems];
global.money = 10;

// Combat variable stuff
global.prevRoom = rm_template;
global.enemies = [];
array_push(global.enemies, global.enemyDB.zone1.mob1);
array_push(global.enemies, global.enemyDB.zone1.mob1);
array_push(global.enemies, global.enemyDB.zone1.mob1);
array_push(global.enemies, global.enemyDB.zone1.mob1);
array_push(global.enemies, global.enemyDB.zone1.mob1);

// TEMP STUFF PLEASE CHANGFE THIS
global.characters = [new MC(), new Himiko(), new Trevor()];
global.party = [global.characters[0], global.characters[1]];

/*
[0] = read email/met himiko
[1] = met trevor
[2] = first combat
*/
global.triggers = [false, false, false];

global.timeSpent = 0;

// Enums
enum playerState {
	idle,
	walking,
}
enum interactableState {
	inactive,
	active,
}
enum textboxState {
	writing,
	idle,
	wait,
}
enum triggerState {
	idle,
	triggered,
}
enum itemType {
	item,
	consumable,
	weapon,
	accessory,
	key,
}
enum targetType {
	singleTarget,
	allTarget,
	singleTargetEnemies,
	allTargetEnemies,
	singleTargetAll,
	allTargetAll,
	selfTarget,
	singleTargetDead,
	allTargetDead,
}
enum skillType {
	attack,
	buff,
	heal,
}
enum charNum {
	mc,
	himiko,
	trevor,
}

// Room dimensions array[rm][0,1] where 0 is width and 1 is height
global.roomDim[rm_roomDay][0] = 704;
global.roomDim[rm_roomDay][1] = 704;
global.roomDim[rm_forestRoomEntrance][0] = 832;
global.roomDim[rm_forestRoomEntrance][1] = 960;
global.roomDim[rm_forestRoomPath][0] = 2496;
global.roomDim[rm_forestRoomPath][1] = 1664;
global.roomDim[rm_forestCrossroad][0] = 1344;
global.roomDim[rm_forestCrossroad][1] = 1344;
global.roomDim[rm_forestCityPath][0] = 1408;
global.roomDim[rm_forestCityPath][1] = 704;
global.roomDim[rm_forestCityEntrance][0] = 704;
global.roomDim[rm_forestCityEntrance][1] = 704;
global.roomDim[rm_city][0] = 2112;
global.roomDim[rm_city][1] = 2112;
global.roomDim[rm_house1_downstairs][0] = 704;
global.roomDim[rm_house1_downstairs][1] = 704;
global.roomDim[rm_house1_upstairs][0] = 704;
global.roomDim[rm_house1_upstairs][1] = 704;
global.roomDim[rm_house1_rooms][0] = 896;
global.roomDim[rm_house1_rooms][1] = 704;
global.roomDim[rm_deepForest_entrance][0] = 1344;
global.roomDim[rm_deepForest_entrance][1] = 1024;
global.roomDim[rm_battle][0] = 704;
global.roomDim[rm_battle][1] = 704;
global.roomDim[rm_demoEnd][0] = 704;
global.roomDim[rm_demoEnd][1] = 704;