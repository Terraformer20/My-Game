 /// @description Setup variables

enum battlePhase {
	init,
	startTurn,
	playerTurn,
	process,
	checkFinish,
	endTurn,
	win,
	lose,
	startWait,
	priority,
	processWait,
	winWait,
}

enum battlePage {
	main,
	skill,
	item,
	height,
	attack,
	useSkill,
	useItem,
}

enum mtvnLevel {
	despair = 50,
	unmotivated = 75,
	normal = 100,
	motivated = 125,
	superMotivated = 150,
}

currPhase = battlePhase.init;
allyTurn = 0;

global.alliedUnits = [];
global.enemyUnits = [];
global.units = [];
global.selectedUnit = noone;
global.aliveAllies = [];
global.aliveEnemies = [];
global.deadAllies = [];
global.deadEnemies = [];

// THINK ABOUT A TIMER SYSTEM FOR EFFECTS
global.statTimer = {};

optionSelected = array_create(battlePage.height);
currPage = battlePage.main;
targetSelected = 0;
selectIndex = 0;
currTargetType = undefined;
targetingAllies = false;
inventoryPage = 0;
global.run = false;

enemyPos = [[[352, 422]],
		[[214, 422], [469, 422]],
		[[156, 422], [352, 422], [548, 422]],
		[[140, 342], [442, 342], [281, 422], [563, 422]],
		[[156, 342], [352, 342], [548, 342], [254, 422], [450, 422]]];
		
playerMoves = [];

global.levelUp = {
	// Teal's level up stats
	mc : {
		maxHp: [0, 0, 1],
		maxMp: [0, 0, 1],
		str: [0, 0, 1],
		def: [0, 0, 1],
		spd: [0, 0, 1],
		luck: [0, 0, 1],
		skill : [undefined, undefined, undefined, undefined],
	},
	
	// Himiko's level up stats
	himiko : {
		maxHp: [0, 0, 1],
		maxMp: [0, 0, 1],
		str: [0, 0, 1],
		def: [0, 0, 1],
		spd: [0, 0, 1],
		luck: [0, 0, 1],
		skill : [undefined, undefined, undefined, undefined],
	},
	
	// Trevor's level up stats
	trevor : {
		maxHp: [0, 0, 2, 3],
		maxMp: [0, 0, 2, 3],
		str: [0, 0, 2, 3],
		def: [0, 0, 2, 3],
		spd: [0, 0, 2, 3],
		luck: [0, 0, 2, 3],
		skill : [undefined, undefined, global.skHealSelf, undefined],
	},
	
	// maxXp level up stats
	xp : [0, 0, 1, 2],
}












