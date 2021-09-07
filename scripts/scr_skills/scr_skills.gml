// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function halfStat(val) {
	return val/2;
}

function insertTimer(timer, stat, time, effect) {
	if (variable_struct_exists(timer, stat)) {
		array_push(variable_struct_get(timer, stat), [time, effect]);
	} else {
		variable_struct_set(timer, stat, [[time, effect]]);
	}
}

function changeMtvnStats(target, multiplier) {
	target.currStat.str *= multiplier;
	target.currStat.def *= multiplier;
	target.currStat.spd *= multiplier;
	target.currStat.luck *= 2-multiplier;
}

// Basic attack
function skAttack(user, target) {
	var dmg = user.currStat.str - target.currStat.def;
	target.currStat.hp -= max(dmg, 0);
	return dmg;
}
global.skAttack = {
	name : "Basic Attack",
	effect : skAttack,
	desc : "",
	mpCost : 0,
	skType : skillType.attack,
}

// Basic Defend
function skDefend(user, target) {
		target.currStat.def = target.currStat.def * 2;
		insertTimer(global.statTimer[$ target], "def", 0, halfStat);
		return 0;
}
global.skDefend = {
	name : "Basic Defend",
	effect : skDefend,
	desc : "",
	mpCost : 0,
	skType : skillType.buff,
}

function skRun(user, target) {
	randomize();
	var playerRoll = user.currStat.spd + irandom(8);
	var enemyRoll = target.currStat.spd + irandom(8);
	if (playerRoll >= enemyRoll) {
		return true;
	} 
	return false;
}
global.skRun = {
	name : "Run",
	effect : skRun,
	desc : "Run like a baby.",
	mpCost : 0,
	skType : skillType.attack,
}

function skHealSelf(user, target) {
	target.currStat.hp = min(target.currStat.hp + 5, target.currStat.maxHp);
	return 0;
}
global.skHealSelf = {
	name : "Self-Aid",
	effect : skHealSelf,
	desc : "Heals self for 5 hp.",
	mpCost : 5,
	target : targetType.selfTarget,
	skType : skillType.heal,
}

function skMotivate(user, target) {
	target.currStat.mtvn = min(target.currStat.mtvn + 25, target.currStat.maxMtvn);
	return 0;
}
global.skMotivate = {
	name : "Motivate",
	effect : skMotivate,
	desc : "Increases target's motivation by 25.",
	mpCost : 5,
	target : targetType.singleTargetAll,
	skType : skillType.buff,
}

function skSobStory(user, target) {
	for (var i = 0; i < array_length(global.units); i += 1) {
		if (!global.units[i].isDead)
			global.units[i].currStat.mtvn = max(global.units[i].currStat.mtvn - 25, 0);
	}
	return 0;
}
global.skSobStory = {
	name : "Sob Story",
	effect : skSobStory,
	desc : "Decrease EVERYONE's motivation by 25.",
	mpCost : 10,
	target : targetType.allTargetAll,
	skType : skillType.buff,
}

function skUseItem(target, item) {
	item.effect(target.currStat);
}
global.skUseItem = {
	effect : skUseItem,
}

function skHeavyAttack(user, target) {
	var dmg = 2*user.currStat.str - target.currStat.def;
	target.currStat.hp -= max(dmg, 0);
	return dmg;
}
global.skHeavyAttack = {
	name : "Heavy Attack",
	effect : skHeavyAttack,
	desc : "Strikes an enemy with a heavy attack.",
	mpCost : 5,
	target : targetType.singleTargetEnemies,
	skType : skillType.attack,
}













