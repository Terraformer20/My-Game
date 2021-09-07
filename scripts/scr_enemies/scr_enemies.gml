// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.enemyDB = {
	zone1: {
		mob1: {
			name : "Forest Slime",
			sprite: spr_forest_slime,
			hp : 10,
			maxHp : 10,
			str : 2,
			def : 0,
			spd : 0,
			rangeSpd : [0, 0],
			luck : 1,
			mtvn : 50,
			maxMtvn : 100,
			skills : [skAttack],
			targetFunction: targetRandom,
			specialStuff : {},
			xp: 1,
			money: 2,
		}
	}
}

// TODO
function startBattle() {
	global.prevRoom = room;
	transitionStart(rm_battle, obj_player.x, obj_player.y, seq_base_out, seq_dummy_in);
}

function endBattle() {
	// Revive dead characters
	for (var i = 0; i < array_length(global.alliedUnits); i += 1) {
			global.party[i].hp = max(global.alliedUnits[i].currStat.hp, 1);
			global.party[i].mp = global.alliedUnits[i].currStat.mp;
	}
	transitionStart(global.prevRoom, obj_player.x, obj_player.y, seq_dummy_out, seq_battle_in);
}