// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function cityLemonadeYes() {
	if (global.money >= 5) {
		giveItem(global.itemsDB.consumables.potion, 1, obj_lemonade_stand); 
		global.money -= 5;
	} else {
		createDefaultTextbox("Hey kid, you don't have enough money... Is my job a joke to you or something???", obj_lemonade_stand);
	}
}

function cityLemonadeNo() {
	createDefaultNamedTextbox("Hey if you're not a paying customer then SCRAM!", obj_lemonade_stand, "Markus");
} 