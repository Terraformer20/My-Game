/// @description Handle Changing Selections and What Not

// Handle opening and closing the menu
inputExit = keyboard_check_pressed(global.exitKey);
if (!global.pause) {
	if (inputExit && global.playerControl && !global.midTransition) {
		global.pause = true;
		global.playerControl = false;
		image_alpha = 255;
	} else {
		exit;
	}
} else if (global.pause) {
	inputUp = keyboard_check_pressed(global.upKey);
	inputDown = keyboard_check_pressed(global.downKey);
	inputAccept = keyboard_check_pressed(global.acceptKey);
	inputLeft = keyboard_check_pressed(global.leftKey);
	inputRight = keyboard_check_pressed(global.rightKey);

	var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);
	
	// If you are changing the settings
	if (inputting) {
		switch(dsGrid[# 1, menuOption[page]]) {
			// Change input to new key if it is not already set to another key except for your current key
			case menuElementType.input: {
				var kk = keyboard_key, failed = false;
				if (kk == 0) exit;
				for (var i = 0; i < dsHeight; i += 1) {
					if (kk == dsGrid[# 3, i]) {
						failed = true;
					}
				}
				
				// Do thing based on if the key was successfully changed or not
				if (failed) {
					// Play some failed 
				} else {
					dsGrid[# 3, menuOption[page]] = kk;
					variable_global_set(dsGrid[# 2, menuOption[page]], kk);
					inputting = false;
				}
			}; break;
			// Change slider value
			case menuElementType.slider: {
				var hInput = keyboard_check(global.rightKey) - keyboard_check(global.leftKey);
				if (hInput != 0) {
					dsGrid[# 3, menuOption[page]] += hInput*0.01;
					dsGrid[# 3, menuOption[page]] = clamp(dsGrid[# 3, menuOption[page]], 0, 1);
				}
				if (keyboard_check_pressed(global.exitKey)) {
					inputting = false;
				}
			}; break;
			// Use items
			case menuElementType.itemAccessor: {
				if (menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
					var currItem = itemArray[menuOption[page] + inventoryPage * 8];
					// Change Target
					if (currItem.target == targetType.singleTarget && targetSelected >= 0) {
						var selectionChange = keyboard_check_pressed(global.rightKey) - keyboard_check_pressed(global.leftKey);
						if (selectionChange != 0) {
							targetSelected = (targetSelected + selectionChange + array_length(global.party)) % array_length(global.party);
							playUIAudio(snd_menu_optionsChange);
						}
					}
					// Use Item Case
					if (keyboard_check_pressed(global.acceptKey) && currItem.type = itemType.consumable) {
						// Use item on target based on 
						switch (currItem.target) {
							case targetType.allTarget: {
								for (var i = 0; i < array_length(global.party); i += 1) {
									currItem.effect(global.party[i]);
								}
							}; break
							case targetType.singleTarget: {
								currItem.effect(global.party[targetSelected]);
							}; break;
						}
						global.inventory[page-8][? currItem] -= 1;
					
						// Delete item if 0 remaining and reupdate pages
						if (global.inventory[page-8][? currItem] == 0) {
							ds_map_delete(global.inventory[page-8], currItem);
							var tempItemUpdate = updateItemArray(page-8, 8);
							maxInventoryPage = tempItemUpdate[0];
							itemArray = tempItemUpdate[1];
							if (inventoryPage >= maxInventoryPage) {
								inventoryPage = maxInventoryPage - 1;
							}
						}
					
						// Exit this section of the menu
						keyboard_key_press(global.exitKey);
						keyboard_key_release(global.exitKey);
					}
					// Exit Selection Screen
					if (keyboard_check_pressed(global.exitKey)) {
						inputting = false;
						targetSelected = -1;
					}
				} else {
					inputting = false;
				}
			}; break;
		}	
	} else {
		// Change what option is selected
		var oChange = inputDown - inputUp;
		var invChange = inputRight - inputLeft;
		if (oChange != 0) {
			playUIAudio(snd_menu_optionsChange);
			if (menuOption[page] == 0 && oChange < 0) {
				inventoryPage = (inventoryPage + maxInventoryPage + oChange) % maxInventoryPage;
			} else if (menuOption[page] == dsHeight-1 && oChange > 0) {
				inventoryPage = (inventoryPage + maxInventoryPage + oChange) % maxInventoryPage;
			}
			menuOption[page] = (menuOption[page] + dsHeight + oChange) % dsHeight;
		}
		if (page >= 8 && page <= 11 && invChange != 0) {
			inventoryPage = (inventoryPage + maxInventoryPage + invChange) % maxInventoryPage;
		}
		
		// Handle moving back in the menu or exiting the menu
		if (inputExit) {
			menuOption[page] = 0;
			switch page {
				// In-game hub menu
				case menuPage.main: {
					global.pause = false;
					global.playerControl = true;
					image_alpha = 0;
				} break;
				// Settings menu
				case menuPage.settings: {
					if (global.mainMenu) {
						page = 2;
					} else {
						page = 0;
					}
				} break;
				// Save/load menu
				case menuPage.saveLoad: {
					global.pause = false;
					global.playerControl = true;
					image_alpha = 0;
					page = 0;
				}; break;
				// Save menu
				case menuPage.save: page = 3; break;
				case menuPage.load: {
					if (global.mainMenu) {
						page = 2;
					} else {
						page = 3;
					}
				}; break;
				case menuPage.equip: {
					page = 0;
					targetSelected = -1;
				}; break;
				case menuPage.inventory: {
					page = 0;
				}; break;
				case menuPage.consumables:
				case menuPage.weapons:
				case menuPage.accessories:
				case menuPage.key: {
					page =7;
				}; break;
				case menuPage.equipWeapon:
				case menuPage.equipAccessory: {
					inventoryPage = 0;
					optionSelected[page] = 0;
					page = menuPage.equip;
				}; break;
				case menuPage.skills: {
					page = menuPage.main;
					targetSelected = -1;
				}; break;
				case menuPage.equipSkill: {
					page = menuPage.skills;
				}; break;
			}
		}
	}
	
	// If not inputting cases
	if (!inputting) {
		switch page {
			case menuPage.skills:
			case menuPage.equip: {
				var selectionChange = keyboard_check_pressed(global.rightKey) - keyboard_check_pressed(global.leftKey);
				if (selectionChange != 0) {
					targetSelected = (targetSelected + selectionChange + array_length(global.party)) % array_length(global.party);
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;	
			case menuPage.equipSkill:
			case menuPage.equipWeapon:
			case menuPage.equipAccessory: {
				var selectionChange = keyboard_check_pressed(global.rightKey) - keyboard_check_pressed(global.leftKey);
				if (selectionChange != 0) {
					inventoryPage = (inventoryPage + maxInventoryPage + selectionChange) % maxInventoryPage;
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;
		}
	}
	
	// If you press the accept key
	if (inputAccept) {
		playUIAudio(snd_menu_optionsChange);
		switch(dsGrid[# 1, menuOption[page]]) {
			case menuElementType.pageTransfer: {
				page = dsGrid[# 2, menuOption[page]];
				// Update the page contents
				switch (page) {
					case menuPage.settings: {
						menuPages[page][# 3, 0] = global.bgmVolume;
						menuPages[page][# 3, 1] = global.uiVolume;
						for (var i = 2; i < ds_grid_height(menuPages[page]); i += 1) {
							menuPages[page][# 3, i] = variable_global_get(menuPages[page][# 2, i]);
						}
					}; break;
					case menuPage.consumables:
					case menuPage.weapons:
					case menuPage.accessories:
					case menuPage.key: {
						// Update inventory pages
						inventoryPage = 0;
						var tempItemUpdate = updateItemArray(page-8, 8);
						maxInventoryPage = tempItemUpdate[0];
						itemArray = tempItemUpdate[1];
					}; break;
					case menuPage.skills:
					case menuPage.equip: {
						targetSelected = 0;
					}; break;
					case menuPage.equipWeapon:
					case menuPage.equipAccessory: {
						// Update inventory pages
						inventoryPage = 0;
						var tempItemUpdate = updateItemArray(page-11, 8);
						maxInventoryPage = tempItemUpdate[0];
						itemArray = tempItemUpdate[1];
					}; break;
					case menuPage.equipSkill: {
						inventoryPage = 0;
						maxInventoryPage = max(ceil(array_length(global.party[targetSelected].skills)/8), 1);
					}; break;
				}
			}; break;
			case menuElementType.scriptRunner: {
					if (page == 4 || page == 5) {
						script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]]);
					} else {
						script_execute(dsGrid[# 2, menuOption[page]]);
					}
				}; break;
			case menuElementType.input: {
				if (inputting == false) {
					inputting = true;
				}
			}; break;
			case menuElementType.shift:
			case menuElementType.slider: 
			case menuElementType.toggle:
				if (inputting && dsGrid[# 1, menuOption[page]]) {
					script_execute(dsGrid[# 2, menuOption[page]], dsGrid[# 3, menuOption[page]])
				}
				inputting = !inputting;
				break;
			case menuElementType.itemAccessor: {
				if (menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
					var currItem = itemArray[menuOption[page] + inventoryPage * 8];
					switch currItem.type {
						// Consumables
						case itemType.consumable: {
							inputting = true;
							switch(currItem.target) {
								case targetType.allTarget: targetSelected = -2; break;
								case targetType.singleTarget: targetSelected = 0; break;
							}
						}; break;
						// Weapons and Accessories
						case itemType.accessory:
						case itemType.weapon: {
							// Equip the current thing and unequip what is in the slot
							var currChar = global.party[targetSelected];
							if (page == menuPage.equipWeapon) {
								// Equip weapon and dequip and store replaced weapon changing stats as well
								var tempWeapon = currChar.weapon;
								if (tempWeapon != undefined && tempWeapon != noone) {
									equipStatsSub(currChar, tempWeapon);
									
									if (ds_map_exists(global.inventory[1], tempWeapon)) {
										global.inventory[1][? tempWeapon] += 1;
									} else {
										global.inventory[1][? tempWeapon] = 1;
									}
								}
								global.party[targetSelected].weapon = currItem;
								equipStatsAdd(currChar, currItem);
								
								// Remove equipped weapon from inventory
								global.inventory[1][? currItem] -= 1;
								if (global.inventory[1][? currItem] <= 0) {
									ds_map_delete(global.inventory[1], currItem);
								}
							} else if (page == menuPage.equipAccessory) {
								// Equip accessory and dequip and store replaced accessory
								var tempAccessory = global.party[targetSelected].accessory;
								if (tempAccessory != undefined && tempAccessory != noone) {
									equipStatsSub(currChar, tempAccessory);
									
									if (ds_map_exists(global.inventory[2], tempAccessory)) {
										global.inventory[2][? tempAccessory] += 1;
									} else {
										global.inventory[2][? tempAccessory] = 1;
									}
								}
								global.party[targetSelected].accessory = currItem;
								equipStatsAdd(currChar, currItem);
								
								// Remove equipped accessory from inventory
								global.inventory[2][? currItem] -= 1;
								if (global.inventory[2][? currItem] <= 0) {
									ds_map_delete(global.inventory[2], currItem);
								}
							}
							
							// Exit this part of the menu
							keyboard_key_press(global.exitKey);
							keyboard_key_release(global.exitKey);
						}
					}
				} else if (page == menuPage.equipAccessory) {
					var currChar = global.party[targetSelected];
					var tempAccessory = currChar.accessory;
					if (tempAccessory != undefined) {
						// Add to inventory and remove stats
						if (ds_map_exists(global.inventory[2], tempAccessory)) {
							global.inventory[2][? tempAccessory] += 1;
						} else {
							global.inventory[2][? tempAccessory] = 1;
						}
						equipStatsSub(currChar, tempAccessory);
						currChar.accessory = undefined;
					}
					// Exit this part of the menu
					keyboard_key_press(global.exitKey);
					keyboard_key_release(global.exitKey);
					
				} else if (page == menuPage.equipWeapon) {
					var currChar = global.party[targetSelected];
					var tempWeapon = currChar.weapon;
					if (tempWeapon != undefined) {
						// Add to inventory and remove stats
						if (ds_map_exists(global.inventory[1], tempWeapon)) {
							global.inventory[1][? tempWeapon] += 1;
						} else {
							global.inventory[1][? tempWeapon] = 1;
						}
						equipStatsSub(currChar, tempWeapon);
						currChar.weapon = undefined;
					}
					// Exit this part of the menu
					keyboard_key_press(global.exitKey);
					keyboard_key_release(global.exitKey);
				}
				
			}; break;
			case menuElementType.skillAccessor: {
				var currChar = global.party[targetSelected];
				if (menuOption[page] + 8*inventoryPage < array_length(currChar.allSkills)) {
					if (menuOption[menuPage.skills] < array_length(currChar.skills)) {
						currChar.skills[menuOption[menuPage.skills]] = currChar.allSkills[menuOption[page] + 8*inventoryPage];
					} else {
						array_push(currChar.skills, currChar.allSkills[menuOption[page] + 8*inventoryPage]);
					}
					
					// Exit this section of the menu
					keyboard_key_press(global.exitKey);
					keyboard_key_release(global.exitKey);
				}
				// Check if there is a skill, then equip it
			}; break;
		}
	
		// Audio TODO
	}
}