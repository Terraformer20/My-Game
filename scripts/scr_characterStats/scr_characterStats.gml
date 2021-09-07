// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function updateStats(character) {
	with (character) {
		if (weapon != undefined) {
			print(maxHp, " ", weapon.maxHp)
			maxHp += weapon.maxHp;
			maxMp += weapon.maxMp;
			str += weapon.str;
			def += weapon.def;
			spd += weapon.spd;
			luck += weapon.luck;
			maxMtvn += weapon.maxMtvn;
			hp += weapon.maxHp;
			mp += weapon.maxMp;
		}
	
		if (accessory != undefined) {
			maxHp += accessory.maxHp;
			maxMp += accessory.maxMp;
			str += accessory.str;
			def += accessory.def;
			spd += accessory.spd;
			luck += accessory.luck;
			maxMtvn += accessory.maxMtvn;
			hp += accessory.maxHp;
			mp += accessory.maxMp;
		}
	}
}

function Character() constructor {
	// Stats
	name = "";
	hp = 0;
	mp = 0;
	str = 0;
	def = 0;
	spd = 0;
	luck = 0;
	maxHp = 0;
	maxMp = 0;
	xp = 0;
	maxXp = 0;
	level = 0;
	mtvn = 50;
	maxMtvn = 100;
	
	// Equipment
	weapon = undefined;
	accessory = undefined;
	
	// Skills
	skills = [];
	allSkills = [];
}

function MC() : Character() constructor {
	name = global.playerName;
	hp = 10;
	mp = 10;
	str = 3;
	def = 1;
	spd = 1;
	luck = 3;
	maxHp = 10;
	maxMp = 10;
	xp = 0;
	maxXp = 1;
	level = 1;
	
	weapon = global.itemsDB.weapons.sword1;
	skills = [global.skHeavyAttack, global.skHealSelf];
	allSkills = [global.skHeavyAttack, global.skHealSelf];
	
	updateStats(self);
}

function Himiko() : Character() constructor {
	name = "Himiko";
	hp = 15;
	mp = 10;
	str = 2;
	def = 3;
	spd = 2;
	luck = 1;
	maxHp = 15;
	maxMp = 10;
	xp = 0;
	maxXp = 1;
	level = 1;
	
	weapon = global.itemsDB.weapons.sword1;
	skills = [global.skHeavyAttack, global.skMotivate];
	allSkills = [global.skHeavyAttack, global.skMotivate];
	
	updateStats(self);
}

function Trevor() : Character() constructor {
	name = "Trevor";
	hp = 10;
	mp = 10;
	str = 5;
	def = 1;
	spd = 1;
	luck = 1;
	maxHp = 20;
	maxMp = 10;
	xp = 0;
	maxXp = 1;
	level = 1;
	skills = [global.skMotivate];
	allSkills = [global.skMotivate];
	
	updateStats(self);
}