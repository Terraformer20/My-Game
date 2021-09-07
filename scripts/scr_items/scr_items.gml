// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function itemSort(arg1, arg2) {
	if (arg1.name > arg2.name) return 1;
	if (arg1.name < arg2.name) return -1;
	return 0;
}

function updateItemArray(page, perPage) {
	if (ds_map_empty(global.inventory[page])) {
		var maxInventoryPage = 1;
	} else {
		var maxInventoryPage = ceil(array_length(ds_map_keys_to_array(global.inventory[page])) / perPage);
	}
			
	// Update itemArray
	var items = global.inventory[page];
	if (ds_map_empty(items)) {
		var itemArray = [];
	} else {
		var itemArray = ds_map_keys_to_array(items);
		array_sort(itemArray, itemSort);
	}
	return [maxInventoryPage, itemArray];
}

function giveItem(item, amount, parent) {
	if (is_undefined(amount)) amount = 1;
	if (is_undefined(parent)) parent = undefined;
	var targetInv = undefined;
	switch(item.type) {
		case itemType.consumable: targetInv = global.inventory[0]; break;
		case itemType.weapon: targetInv = global.inventory[1]; break;
		case itemType.accessory: targetInv = global.inventory[2]; break;
		case itemType.key: targetInv = global.inventory[3]; break;
	}
	if (ds_map_exists(targetInv, item)) {
		ds_map_set(targetInv, item, targetInv[? item] + amount);
	} else {
		ds_map_set(targetInv, item, amount);
	}
	
	if (amount == 1) {
		createDefaultTextbox(str("You obtained a ", item.name, "!"), parent);
	} else {
		createDefaultTextbox(str("You obtained ", amount, " ", item.name, "s!"), parent);
	}
}

function equipStatsSub(currChar, tempItem) {
	currChar.maxHp -= tempItem.maxHp;
	currChar.maxMp -= tempItem.maxMp;
	currChar.str -= tempItem.str;
	currChar.def -= tempItem.def;
	currChar.spd -= tempItem.spd;
	currChar.luck -= tempItem.luck;
	currChar.maxMtvn -= tempItem.maxMtvn;
	currChar.hp = min(currChar.hp, currChar.maxHp);
	currChar.mp = min(currChar.mp, currChar.maxMp);
}

function equipStatsAdd(currChar, tempItem) {
	currChar.maxHp += tempItem.maxHp;
	currChar.maxMp += tempItem.maxMp;
	currChar.str += tempItem.str;
	currChar.def += tempItem.def;
	currChar.spd += tempItem.spd;
	currChar.luck += tempItem.luck;
	currChar.maxMtvn += tempItem.maxMtvn;
}

global.itemsDB = {
	consumables: {
		potion: {
			name : "Basic Potion",
			description : "BLAH BLAH BLAH",
			effectDescription : "Heals X hp to target ally.",
			effect : function(player) {
				player.hp = player.hp + 10;
			},
			type : itemType.consumable,
			target : targetType.singleTarget,
		},
		potion2: {
			name : "Second Potion",
			description : "WAWAWEEWA",
			effectDescription : "x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x",
			effect : function(player) {
				player.hp = player.hp + 10;
			},
			type : itemType.consumable,
			target : targetType.allTarget,
		},
	},
	weapons: {
		template: {
			name : "",
			maxHp : 0,
			maxMp : 0,
			str : 0,
			def : 0,
			spd : 0,
			luck : 0,
			maxMtvn : 0,
			type : itemType.weapon,
			description : undefined,
			effectDescription : undefined,
		},
		sword1: {
			name : "Rusty Sword",
			maxHp : 0,
			maxMp : 0,
			str : 1,
			def : 0,
			spd : 0,
			luck : 0,
			maxMtvn : 0,
			type : itemType.weapon,
			description : undefined,
			effectDescription : undefined,
		},
		sword2: {
			name : "Dull Sword",
			maxHp : 2,
			maxMp : 0,
			str : 7,
			def : 0,
			spd : 2,
			luck : 0,
			maxMtvn : 0,
			type : itemType.weapon,
			description : undefined,
			effectDescription : undefined,
		},
	},
	accessories: {
		toiletPaper: {
			name: "Toilet Paper",
			description: "A desperate man's plea for solitude.",
			maxHp : 0,
			maxMp : 5,
			str : 0,
			def : 3,
			spd : 3,
			luck : 0,
			maxMtvn : 0,
			type : itemType.accessory,
			effectDescription : undefined,
		}
	},
	key: {
		manual: {
			name: "Combat Manual",
			type: itemType.key,
			description: "A popular published work detailing how to fight. The main ideas are carefully circled for you.",
			effectDescription: undefined,
		}
	},
}

/*
	name = "";
	maxHp = 0;
	maxMp = 0;
	str = 0;
	def = 0;
	spd = 0;
	luck = 0;
	maxMtvn = 0;
	type = itemType.equipment;
	
*/