/// @description Insert description here
// You can write your code in this editor

global.pause = false;
viewWidth = camera_get_view_width(view_camera[0]);
viewHeight = camera_get_view_height(view_camera[0]);

display_set_gui_size(viewWidth, viewHeight);

enum menuPage {
	main,
	settings,
	mainMenu,
	saveLoad,
	save,
	load,
	equip,
	inventory,
	consumables,
	weapons,
	accessories,
	key,
	equipWeapon,
	equipAccessory,
	skills,
	equipSkill,
	height,
}

enum menuElementType {
	scriptRunner,
	pageTransfer,
	slider,
	shift,
	toggle,
	input,
	itemAccessor,
	placeholder,
	skillAccessor,
}

// Create Menu Pages
dsMenuMain = createMenuPage(
	["EQUIP", menuElementType.pageTransfer, menuPage.equip],
	["SKILLS", menuElementType.pageTransfer, menuPage.skills],
	["INVENTORY", menuElementType.pageTransfer, menuPage.inventory],
	["SETTINGS", menuElementType.pageTransfer, menuPage.settings],
	["MAIN MENU", menuElementType.scriptRunner, returnToMainMenu]
);

dsMenuSettings = createMenuPage(
	["BGM", menuElementType.slider, changeBGMVolume, global.bgmVolume, [0,1]],
	["UI", menuElementType.slider, changeGUIVolume, global.uiVolume, [0,1]],
	["UP", menuElementType.input, "upKey", global.upKey],
	["LEFT", menuElementType.input, "leftKey", global.leftKey],
	["DOWN", menuElementType.input, "downKey", global.downKey],
	["RIGHT", menuElementType.input, "rightKey", global.rightKey],
	["SPRINT", menuElementType.input, "sprintKey", global.sprintKey],
	["ACCEPT", menuElementType.input, "acceptKey", global.acceptKey],
	["EXIT/MENU", menuElementType.input, "exitKey", global.exitKey]
);

dsMainMenu = createMenuPage(
	["New Game", menuElementType.scriptRunner, startGame],
	["Continue", menuElementType.pageTransfer, menuPage.load],
	["Options", menuElementType.pageTransfer, menuPage.settings],
	["Exit", menuElementType.scriptRunner, exitGame]
);

dsMenuSaveLoad = createMenuPage(
	["Save", menuElementType.pageTransfer, menuPage.save],
	["Load", menuElementType.pageTransfer, menuPage.load]
);

dsMenuSave = createMenuPage(
	["Save Slot 0:", menuElementType.scriptRunner, saveGame, 0],
	["Save Slot 1:", menuElementType.scriptRunner, saveGame, 1],
	["Save Slot 2:", menuElementType.scriptRunner, saveGame, 2],
	["Save Slot 3:", menuElementType.scriptRunner, saveGame, 3],
);

dsMenuLoad = createMenuPage(
	["Save Slot 0:", menuElementType.scriptRunner, loadGame, 0],
	["Save Slot 1:", menuElementType.scriptRunner, loadGame, 1],
	["Save Slot 2:", menuElementType.scriptRunner, loadGame, 2],
	["Save Slot 3:", menuElementType.scriptRunner, loadGame, 3],
);

dsMenuEquip = createMenuPage();

dsMenuInventory = createMenuPage(
	["CONSUMABLES", menuElementType.pageTransfer, menuPage.consumables],
	["WEAPONS", menuElementType.pageTransfer, menuPage.weapons],
	["ACCESSORIES", menuElementType.pageTransfer, menuPage.accessories],
	["KEY ITEMS", menuElementType.pageTransfer, menuPage.key],
);

dsMenuConsumables = createMenuPage(
	["ITEM", menuElementType.itemAccessor, 0],
	["ITEM", menuElementType.itemAccessor, 1],
	["ITEM", menuElementType.itemAccessor, 2],
	["ITEM", menuElementType.itemAccessor, 3],
	["ITEM", menuElementType.itemAccessor, 4],
	["ITEM", menuElementType.itemAccessor, 5],
	["ITEM", menuElementType.itemAccessor, 6],
	["ITEM", menuElementType.itemAccessor, 7],
);

dsMenuWeapons = createMenuPage(
	["ITEM", menuElementType.placeholder, 0],
	["ITEM", menuElementType.placeholder, 1],
	["ITEM", menuElementType.placeholder, 2],
	["ITEM", menuElementType.placeholder, 3],
	["ITEM", menuElementType.placeholder, 4],
	["ITEM", menuElementType.placeholder, 5],
	["ITEM", menuElementType.placeholder, 6],
	["ITEM", menuElementType.placeholder, 7],
);

dsMenuAccessories = createMenuPage(
	["ITEM", menuElementType.placeholder, 0],
	["ITEM", menuElementType.placeholder, 1],
	["ITEM", menuElementType.placeholder, 2],
	["ITEM", menuElementType.placeholder, 3],
	["ITEM", menuElementType.placeholder, 4],
	["ITEM", menuElementType.placeholder, 5],
	["ITEM", menuElementType.placeholder, 6],
	["ITEM", menuElementType.placeholder, 7],
);

dsMenuKeyItems = createMenuPage(
	["ITEM", menuElementType.itemAccessor, 0],
	["ITEM", menuElementType.itemAccessor, 1],
	["ITEM", menuElementType.itemAccessor, 2],
	["ITEM", menuElementType.itemAccessor, 3],
	["ITEM", menuElementType.itemAccessor, 4],
	["ITEM", menuElementType.itemAccessor, 5],
	["ITEM", menuElementType.itemAccessor, 6],
	["ITEM", menuElementType.itemAccessor, 7],
);

dsMenuEquip = createMenuPage(
	["WEAPON", menuElementType.pageTransfer, menuPage.equipWeapon],
	["ACCESSORY", menuElementType.pageTransfer, menuPage.equipAccessory],
);

dsMenuEquipA = createMenuPage(
	["ITEM", menuElementType.itemAccessor, 0],
	["ITEM", menuElementType.itemAccessor, 1],
	["ITEM", menuElementType.itemAccessor, 2],
	["ITEM", menuElementType.itemAccessor, 3],
	["ITEM", menuElementType.itemAccessor, 4],
	["ITEM", menuElementType.itemAccessor, 5],
	["ITEM", menuElementType.itemAccessor, 6],
	["ITEM", menuElementType.itemAccessor, 7],
);

dsMenuEquipW = createMenuPage(
	["ITEM", menuElementType.itemAccessor, 0],
	["ITEM", menuElementType.itemAccessor, 1],
	["ITEM", menuElementType.itemAccessor, 2],
	["ITEM", menuElementType.itemAccessor, 3],
	["ITEM", menuElementType.itemAccessor, 4],
	["ITEM", menuElementType.itemAccessor, 5],
	["ITEM", menuElementType.itemAccessor, 6],
	["ITEM", menuElementType.itemAccessor, 7],
);

dsMenuSkills = createMenuPage(
	["SKILL1", menuElementType.pageTransfer, menuPage.equipSkill],
	["SKILL2", menuElementType.pageTransfer, menuPage.equipSkill],
	["SKILL3", menuElementType.pageTransfer, menuPage.equipSkill],
	["SKILL4", menuElementType.pageTransfer, menuPage.equipSkill],
);

dsMenuEquipSkill = createMenuPage(
	["SKILL", menuElementType.skillAccessor, 0],
	["SKILL", menuElementType.skillAccessor, 1],
	["SKILL", menuElementType.skillAccessor, 2],
	["SKILL", menuElementType.skillAccessor, 3],
	["SKILL", menuElementType.skillAccessor, 4],
	["SKILL", menuElementType.skillAccessor, 5],
	["SKILL", menuElementType.skillAccessor, 6],
	["SKILL", menuElementType.skillAccessor, 7],
);

// Current page is menuPages[page]
page = 0;
menuPages = [dsMenuMain, dsMenuSettings, dsMainMenu, dsMenuSaveLoad, dsMenuSave, dsMenuLoad,
		dsMenuEquip, dsMenuInventory, dsMenuConsumables, dsMenuWeapons, dsMenuAccessories, 
		dsMenuKeyItems, dsMenuEquipW, dsMenuEquipA, dsMenuSkills, dsMenuEquipSkill];
inventoryPage = 0;
maxInventoryPage = 1;
itemArray = [];
targetSelected = -1;

// Option selected on each page is default set to 0
for (var i = 0; i < array_length(menuPages); i += 1) {
	menuOption[i] = 0;
}

inputting = false;
