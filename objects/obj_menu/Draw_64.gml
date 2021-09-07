/// @description Draw Menu

if (!global.pause) exit;

if (keyboard_check_pressed(vk_space)) print(menuOption[page] + 8*inventoryPage);

// Variable setup
var dsGrid = menuPages[page], dsHeight = ds_grid_height(dsGrid);

// Set alignment and fonts
draw_set_font(fnt_textbox);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var c1 = c_black;
var c2 = c_white;
var c3 = make_color_rgb(184, 24, 24);
var c4 = make_color_rgb(11, 48, 140);
var c5 = make_color_rgb(194, 156, 52);
var c6 = c_green;
var startX = 32, startY = 32;
var yBuffer = 20, xBuffer = 32;
var fontSize = font_get_size(fnt_textbox);

function drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer, targetSelected) {
	if (is_undefined(targetSelected)) targetSelected = -1;
	for (var i = 0; i < array_length(global.party); i += 1) {
		// Ha
		var selectionMod = 0;
		if (targetSelected == -2 || targetSelected == i) {
			selectionMod = 25;
		}
		
		startX = (20*(i+1))+(163*i);
		// Create the box and namebox
		draw_rectangle_color(startX-4, 533-fontSize-selectionMod,
							startX+167, 704-selectionMod,c2,c2,c2,c2,false);
		draw_rectangle_color(startX, 537-fontSize-selectionMod,
							startX+163, 521+fontSize-selectionMod,c1,c1,c1,c1,false);
		draw_rectangle_color(startX, 525+fontSize-selectionMod,
							startX+163, 700-selectionMod,c1,c1,c1,c1,false);
		draw_text_ext_color(startX+10, 524-selectionMod, global.party[i].name, xBuffer, 163, c2,c2,c2,c2,255);
		
		draw_set_font(fnt_textboxSmall);
		// Draw health bar
		startY = 525+fontSize+yBuffer;
		var maxHp = global.party[i].maxHp;
		
		var hpRatio = global.party[i].hp/maxHp;
		draw_rectangle_color(startX+10, startY-selectionMod, startX+153, startY+35-selectionMod,c3,c3,c3,c3,true);
		draw_rectangle_color(startX+10, startY-selectionMod, startX+10+hpRatio*143, startY+35-selectionMod,c3,c3,c3,c3,false);
		draw_text_color(startX+15, startY+18-selectionMod,
					"HP:"+string(global.party[i].hp)+"\/"+string(maxHp),c2,c2,c2,c2,255);
					
		// Draw mp bar
		startY = 525+fontSize+yBuffer*2+35;
		var mpRatio = global.party[i].mp/global.party[i].maxMp;
		draw_rectangle_color(startX+10, startY-selectionMod, startX+153, startY+35-selectionMod, c4,c4,c4,c4,true);
		draw_rectangle_color(startX+10, startY-selectionMod, startX+10+mpRatio*143, startY+35-selectionMod, c4,c4,c4,c4,false);
		draw_text_color(startX+15, startY+18-selectionMod,
					"MP:" + string(global.party[i].mp)+"\/"+string(global.party[i].maxMp), c2,c2,c2,c2,255);
		
		// Reset font size
		draw_set_font(fnt_textbox);
	}
}
	
function drawInventoryText(startX, startY, xBuffer, yBuffer, fontSize, inventoryPage, itemArray, page, c2) {
	draw_set_font(fnt_textbox);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	// Inventory Text
	for (var i = 0; i < 8; i += 1) {
		var itemName = "-------------";
		var amount = "";
		
		if (i + 8*inventoryPage < array_length(itemArray)) {
			itemName = itemArray[i + 8*inventoryPage].name;
			amount = "x" + string(global.inventory[page][? itemArray[i + 8*inventoryPage]]);
		}
		draw_text_color(startX+xBuffer, startY+i*(fontSize+yBuffer)+yBuffer+4, itemName, c2, c2, c2, c2, 255);
		draw_text_color(startX+260, startY+i*(fontSize+yBuffer)+yBuffer+4, amount, c2, c2, c2, c2, 255);
	}
}

function drawSkillsText(startX, startY, xBuffer, yBuffer, fontSize, partyNum, c2) {
	draw_set_font(fnt_textbox);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	// Skill Text
	var skillInv = global.party[partyNum].allSkills;
	for (var i = 0; i < 8; i += 1) {
		var skillName = "-----------------";
		
		if (i + 8*inventoryPage < array_length(skillInv)) {
			skillName = skillInv[i + 8*inventoryPage].name;
		}
		draw_text_color(startX+xBuffer, startY+i*(fontSize+yBuffer)+yBuffer+4, skillName, c2, c2, c2, c2, 255);
	}
}
	
function calcStatText(page, baseMod, altMod, c2, c3, c6) {
	var toAdd = 0, modString = "", color = c2;
	if (page != menuPage.equipWeapon && page != menuPage.equipAccessory) {
		toAdd = baseMod;
		if (baseMod != 0) {
			if (baseMod > 0) {
				modString += " (+" + string(baseMod) + ")";
			} else {
				modString += " (" + string(baseMod) + ")";
			}
		}
	} else {
		toAdd = altMod;
		if (altMod != 0) {
			if (altMod > 0) {
				modString += " (+" + string(altMod) + ")";
			} else {
				modString += " (" + string(altMod) + ")";
			}
		}
	}
	if (baseMod > altMod) {
		color = c3;
	} else if (baseMod < altMod) {
		color = c6;
	}
	return [toAdd, modString, color];
}

// Draw based on page
switch(page) {
	// Main Menu Case
	case menuPage.inventory:
	case menuPage.main:	{
		if (page == 7) {
			var width = 230;
			var height = 200;
		} else {
			var width = 200;
			var height = 250;
		}
		draw_rectangle_color(startX-4, startY-4, startX + width + 4, startY + height + 4, c2, c2, c2, c2, false);
		draw_rectangle_color(startX, startY, startX + width, startY + height, c1, c1, c1, c1, false);
		for (var i = 0; i < dsHeight; i += 1) {
			draw_text_color(startX+xBuffer, startY+i*(fontSize+yBuffer)+yBuffer+4, dsGrid[# 0, i], c2, c2, c2, c2, 255);
		}
		
		// Put arrow next to option selected
		draw_sprite(spr_arrow, 0, startX+16, startY+menuOption[page]*(fontSize+yBuffer)+yBuffer+4);
		
		drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer);
		
		// Draw money box
		var moneyString = "$ " + string(global.money);
		var _textWidth = string_width_ext(moneyString, fontSize+(fontSize/2), 672);
		draw_rectangle_color(16, 495-fontSize*2, _textWidth+36, 495, c2,c2,c2,c2,false);
		draw_rectangle_color(20, 495-fontSize*2+4, _textWidth+32, 491, c1,c1,c1,c1,false);
		draw_text_color(25, 495-fontSize, moneyString, c2,c2,c2,c2, 255);
		
	}; break;
	
	// Settings case
	case menuPage.settings: {
		draw_rectangle_color(startX-4, startY-4, startX + 504, startY + 554, c2, c2, c2, c2, false);
		draw_rectangle_color(startX, startY, startX + 500, startY + 550, c1, c1, c1, c1, false);
		draw_text_color(startX+xBuffer/2, startY+yBuffer+4, "Volume", c2, c2, c2, c2, 255);
		draw_text_color(startX+xBuffer/2, startY+3*(fontSize+yBuffer)+yBuffer+4, "Controls", c2, c2, c2, c2, 255);
		for (var i = 0; i < dsHeight; i += 1) {
			if (i < 2) {
				draw_text_color(startX+xBuffer, startY+(i+1)*(fontSize+yBuffer)+yBuffer+4, dsGrid[# 0, i], c2, c2, c2, c2, 255);
			} else {
				draw_text_color(startX+xBuffer, startY+(i+2)*(fontSize+yBuffer)+yBuffer+4, dsGrid[# 0, i], c2, c2, c2, c2, 255);
			}
		}
		
		// Put arrow next to option selected (skipping title texts)
		if (menuOption[page] < 2) {
			draw_sprite(spr_arrow, 0, startX+16, startY+(menuOption[page]+1)*(fontSize+yBuffer)+yBuffer+4);
		} else {
			draw_sprite(spr_arrow, 0, startX+16, startY+(menuOption[page]+2)*(fontSize+yBuffer)+yBuffer+4);
		}
		
		// Draw actual functional components
		for (var i = 0; i < dsHeight; i += 1) {
			// Calculate y position
			if (i < 2) {
				var yPos = startY+(i+1)*(fontSize+yBuffer)+yBuffer+4;
			} else {
				var yPos = startY+(i+2)*(fontSize+yBuffer)+yBuffer+4;
			}
			
			switch(dsGrid[# 1, i]) {
				case menuElementType.slider: {
					var len = 150;
					var currVal = dsGrid[# 3, i], currArray = dsGrid[# 4, i];
					var currPos = (currVal - currArray[0]) / (currArray[1] - currArray[0])
					
					var c = c2;
					if (i == menuOption[page] && inputting) { c = c_yellow; }
					
					draw_rectangle_color(startX+xBuffer*7, yPos-fontSize/2, startX+xBuffer*7+len, yPos+fontSize/2,c,c,c,c,true);
					draw_rectangle_color(startX+xBuffer*7, yPos-fontSize/2, startX+xBuffer*7+(len*currPos), yPos+fontSize/2,c,c,c,c,false);
					draw_text_color(startX+xBuffer*7+len*1.2, yPos, string(floor(currPos * 100)) + "%", c, c, c, c, 255)
				}; break;
				
				case menuElementType.input: {
					var currVal = dsGrid[# 3, i];
					var stringVal;
					
					switch (currVal) {
						case vk_up: stringVal = "UP KEY"; break;
						case vk_left: stringVal = "LEFT KEY"; break;
						case vk_down: stringVal = "DOWN KEY"; break;
						case vk_right: stringVal = "RIGHT KEY"; break;
						case vk_shift: stringVal = "SHIFT"; break;
						case vk_space: stringVal = "SPACE"; break;
						default: stringVal = chr(currVal); break;
					}
					
					var c = c2;
					if (i == menuOption[page] && inputting) { c = c_yellow; }
					
					draw_text_color(startX+xBuffer*8, yPos, stringVal, c, c, c, c, 255);
				}
			}
		}
	} break;
	// Main Menu Case
	case menuPage.mainMenu: {
		// Main Menu variables
		var xPos = 0;
		var yPos = 0;
	
		// Text settings 
		draw_set_halign(fa_middle);
		draw_set_valign(fa_top);
		draw_set_font(fnt_textbox);
		
		draw_text_ext_color(352, 200, "A Personal Matter", 32, 200, c2, c2, c2, c2, 255);
		
		// Outer box
		var boxWidth = 240;
		draw_rectangle_color(xPos+245, yPos+469, xPos+459, yPos+674, c2, c2, c2, c2, false);
		draw_rectangle_color(xPos+249, yPos+473, xPos+455, yPos+670, c1, c1, c1, c1, false);
	
		// Options
		draw_text_ext_color(352, 473, "New Game\nContinue\nOptions\nExit", 48, 234, c2, c2, c2, c2, 255);
		draw_sprite(spr_arrow, 0, xPos+260, yPos+497+((boxWidth/5)*(menuOption[page])));
		
		// Draw controls text
		draw_set_halign(fa_left);
		draw_set_font(fnt_textboxSmall);
		var acceptKey, exitKey;
		switch (global.acceptKey) {
			case vk_up: acceptKey = "Up Key"; break;
			case vk_left: acceptKey = "Left Key"; break;
			case vk_down: acceptKey = "Down Key"; break;
			case vk_right: acceptKey = "Right Key"; break;
			case vk_shift: acceptKey = "Shift"; break;
			case vk_space: acceptKey = "Space"; break;
			default: acceptKey = chr(global.acceptKey); break;
		}
		switch (global.exitKey) {
			case vk_up: exitKey = "Up Key"; break;
			case vk_left: exitKey = "Left Key"; break;
			case vk_down: exitKey = "Down Key"; break;
			case vk_right: exitKey = "Right Key"; break;
			case vk_shift: exitKey = "Shift"; break;
			case vk_space: exitKey = "Space"; break;
			default: exitKey = chr(global.exitKey); break;
		}
		
		draw_text_color(10, 610, str("Controls\nAccept Key: ", acceptKey, "\nExit/Menu Key: ", exitKey), c2,c2,c2,c2,1);
	} break;
	 
	// Save/load menu case
	case menuPage.saveLoad: {
		draw_set_halign(fa_middle);
		draw_rectangle_color(292, 292, 412, 412, c2, c2, c2, c2, false);
		draw_rectangle_color(296, 296, 408, 408, c1, c1, c1, c1, false);
		for (var i = 0; i < dsHeight; i += 1) {
			draw_text_color(352, 311+i*(fontSize+yBuffer)+yBuffer-4, dsGrid[# 0, i], c2, c2, c2, c2, 255);
		}
		draw_sprite(spr_arrow, 0, 306, 311+(menuOption[page])*(fontSize+yBuffer)+yBuffer-4);
	}; break;
	// Save and Load menu both cases since they are the same
	case menuPage.save:
	case menuPage.load: {
		// Create menu layout
		var width = 500;
		var height = 600;
		draw_rectangle_color(352-width/2-4, 352-height/2-4, 352+width/2+4, 352+height/2+4, c2, c2, c2, c2, false);
		draw_rectangle_color(352-width/2, 352-height/2, 352+width/2, 352+height/2, c1, c1, c1, c1, false);
		for (var i = 1; i < dsHeight; i+= 1) {
			draw_line_color(352-width/2,  52+yBuffer+i*(height/dsHeight)-fontSize/2-yBuffer/2,
							352+width/2, 52+yBuffer+i*(height/dsHeight)-fontSize/2-yBuffer/2, c2, c2);
		}
		
		// Draw options and arrow
		for (var i = 0; i < dsHeight; i += 1) {
			// Reset alignment
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			
			// Draw file # text
			draw_text_color(102+xBuffer, 52+yBuffer+i*(height/dsHeight), dsGrid[# 0, i], c2, c2, c2, c2, 255);
			
			var _currSave = variable_global_get("save"+string(i));
			if (_currSave == -1) {
				// Draw default no time played
				draw_set_halign(fa_right);
				draw_text_color(352+width/2-xBuffer/4, 52+yBuffer+i*(height/dsHeight), "--:--", c2, c2, c2, c2, 255);
			} else {
				// Draw player name and level
				draw_text_color(102+xBuffer*2, 52+yBuffer+i*(height/dsHeight)+(height/dsHeight)/3,
								_currSave.playerName + " LVL: " + string(_currSave.playerLevel), c2, c2, c2, c2, 255);
				// Draw location of save
				draw_text_color(102+xBuffer*2, 52+yBuffer+i*(height/dsHeight)+2*(height/dsHeight)/3, _currSave.location, c2, c2, c2, c2, 255);
				
				// Draw time played
				draw_set_halign(fa_right);
				// Hours
				var tempNum = floor(_currSave.playerTime/3600);
				var timeString = "";
				if (tempNum <= 0) {
					timeString += "00:";
				} else {
					timeString += str(tempNum, ":");
				}
				// Minutes
				tempNum = floor(_currSave.playerTime/60) % 60;
				if (tempNum <= 0) {
					timeString += "00:";
				} else {
					timeString += str(tempNum, ":");
				}
				// Seconds
				tempNum = floor(_currSave.playerTime) % 60;
				if (tempNum <= 0) {
					timeString += "00";
				} else {
					timeString += str(tempNum);
				}
				draw_text_color(352+width/2-xBuffer/4, 52+yBuffer+i*(height/dsHeight), string(timeString), c2, c2, c2, c2, 255);
			}
			
		}
		draw_sprite(spr_arrow, 0, 102+xBuffer/2, 52+yBuffer+menuOption[page]*(height/dsHeight))
	}; break;
	case menuPage.consumables:
	case menuPage.weapons:
	case menuPage.accessories:
	case menuPage.key: {
		var width = 318;
		
		if (inputting) {
			drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer, targetSelected);
		} else {
			drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer);
		}
		
		
		// Inventory rectangle
		draw_rectangle_color(startX-4, startY-4, startX + width + 4, startY + 394, c2, c2, c2, c2, false);
		draw_rectangle_color(startX, startY, startX + width, startY + 390, c1, c1, c1, c1, false);

		drawInventoryText(startX, startY, xBuffer, yBuffer, fontSize, inventoryPage, itemArray, page-8, c2);
		
		draw_set_valign(fa_top);
		draw_set_font(fnt_textboxSmall);
		var tempText = "";
		// Description/ability rectangle
		draw_rectangle_color(startX + width + 4, startY-4, 676, startY + 197, c2, c2, c2, c2, false);
		// Description
		draw_rectangle_color(startX + width + 4, startY, 672, startY + 193, c1, c1, c1, c1, false);
		if (menuOption[page] + inventoryPage*8 < array_length(itemArray)) {
			if (inputting && itemArray[menuOption[page] + inventoryPage*8].target == targetType.singleTarget) {
				tempText = "USE ON WHO?";
			} else if (inputting && itemArray[menuOption[page] + inventoryPage*8].target == targetType.allTarget) {
				tempText = "ARE YOU SURE?";
			} else {
				tempText = itemArray[menuOption[page] + inventoryPage*8].description;
			}
		}
		draw_text_ext_color(startX+width+4+xBuffer/2, startY+yBuffer/2,
						tempText, 36, 318-xBuffer/2, c2, c2, c2, c2, 255);
		// Ability
		if (menuOption[page] + inventoryPage*8 < array_length(itemArray) && itemArray[menuOption[page] + inventoryPage*8].effectDescription != undefined) {
			tempText = itemArray[menuOption[page] + inventoryPage*8].effectDescription;
			draw_rectangle_color(startX + width + 4, startY + 197, 676, startY + 394, c2, c2, c2, c2, false);
			draw_rectangle_color(startX + width + 4, startY + 197, 672, startY + 390, c1, c1, c1, c1, false);
			draw_text_ext_color(startX+width+4+xBuffer/2, startY+197+yBuffer/2,
							tempText, 36, 318-xBuffer/2, c2, c2, c2, c2, 255);
		}
		
		// Put arrow next to option selected
		draw_sprite(spr_arrow, 0, startX+16, startY+menuOption[page]*(fontSize+yBuffer)+yBuffer+4);
	
	}; break;
	case menuPage.equipWeapon:
	case menuPage.equipAccessory:
	case menuPage.equip: {
		// Draw the status
		drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer, targetSelected);
		
		var width = 318;
		// Status rectangle
		draw_rectangle_color(startX-4, startY-4, startX + width + 4, startY + 394, c2, c2, c2, c2, false);
		draw_rectangle_color(startX, startY, startX + width, startY + 390, c1, c1, c1, c1, false);
		draw_text_color(startX+xBuffer/2, startY+yBuffer+4, "NAME: " + global.party[targetSelected].name, c2,c2,c2,c2,255);
		
		// Draw equipment and text
		draw_set_font(fnt_textboxSmall);
		var weaponName = "";
		if (global.party[targetSelected].weapon != undefined) {
			weaponName = global.party[targetSelected].weapon.name;
		}
		draw_text_color(startX+xBuffer, startY+yBuffer+6+(fontSize/2+yBuffer), "WEAPON: "+weaponName, c2,c2,c2,c2,255);
		var accessoryName = "";
		if (global.party[targetSelected].accessory != undefined) {
			accessoryName = global.party[targetSelected].accessory.name;
		}
		draw_text_color(startX+xBuffer, startY+yBuffer+6+2*(fontSize/2+yBuffer), "ACCESSORY: "+accessoryName, c2,c2,c2,c2,255);
		
		// Base Stat strings
		var maxHpMod = 0;
		if (global.party[targetSelected].weapon != undefined) maxHpMod += global.party[targetSelected].weapon.maxHp;
		if (global.party[targetSelected].accessory != undefined) maxHpMod += global.party[targetSelected].accessory.maxHp;
		
		var maxMpMod = 0;
		if (global.party[targetSelected].weapon != undefined) maxMpMod += global.party[targetSelected].weapon.maxMp;
		if (global.party[targetSelected].accessory != undefined) maxMpMod += global.party[targetSelected].accessory.maxMp;
		
		var mtvnMod = 0;
		if (global.party[targetSelected].weapon != undefined) mtvnMod += global.party[targetSelected].weapon.maxMtvn;
		if (global.party[targetSelected].accessory != undefined) mtvnMod += global.party[targetSelected].accessory.maxMtvn;
		
		var strMod = 0;
		if (global.party[targetSelected].weapon != undefined) strMod += global.party[targetSelected].weapon.str;
		if (global.party[targetSelected].accessory != undefined) strMod += global.party[targetSelected].accessory.str;

		var defMod = 0;
		if (global.party[targetSelected].weapon != undefined) defMod += global.party[targetSelected].weapon.def;
		if (global.party[targetSelected].accessory != undefined) defMod += global.party[targetSelected].accessory.def;
		
		var spdMod = 0;
		if (global.party[targetSelected].weapon != undefined) spdMod += global.party[targetSelected].weapon.spd;
		if (global.party[targetSelected].accessory != undefined) spdMod += global.party[targetSelected].accessory.spd;
		
		var luckMod = 0;
		if (global.party[targetSelected].weapon != undefined) luckMod += global.party[targetSelected].weapon.luck;
		if (global.party[targetSelected].accessory != undefined) luckMod += global.party[targetSelected].accessory.luck;
			
		// Calculate alternate mods
		var altHpMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altHpMod = itemArray[menuOption[page] + inventoryPage * 8].maxHp;
			if (global.party[targetSelected].accessory != undefined) altHpMod += global.party[targetSelected].accessory.maxHp;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altHpMod = itemArray[menuOption[page] + inventoryPage * 8].maxHp;
			if (global.party[targetSelected].weapon != undefined) altHpMod += global.party[targetSelected].weapon.maxHp;
		} else {
			altHpMod = maxHpMod;
		}
		
		var altMpMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altMpMod = itemArray[menuOption[page] + inventoryPage * 8].maxMp;
			if (global.party[targetSelected].accessory != undefined) altMpMod += global.party[targetSelected].accessory.maxMp;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altMpMod = itemArray[menuOption[page] + inventoryPage * 8].maxMp;
			if (global.party[targetSelected].weapon != undefined) altMpMod += global.party[targetSelected].weapon.maxMp;
		} else {
			altMpMod = maxMpMod;
		}
		
		var altMtvnMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altMtvnMod = itemArray[menuOption[page] + inventoryPage * 8].maxMtvn;
			if (global.party[targetSelected].accessory != undefined) altMtvnMod += global.party[targetSelected].accessory.maxMtvn;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altMtvnMod = itemArray[menuOption[page] + inventoryPage * 8].maxMtvn;
			if (global.party[targetSelected].weapon != undefined) altMtvnMod += global.party[targetSelected].weapon.maxMtvn;
		} else {
			altMtvnMod = mtvnMod;
		}
		
		var altStrMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altStrMod = itemArray[menuOption[page] + inventoryPage * 8].str;
			if (global.party[targetSelected].accessory != undefined) altStrMod += global.party[targetSelected].accessory.str;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altStrMod = itemArray[menuOption[page] + inventoryPage * 8].str;
			if (global.party[targetSelected].weapon != undefined) altStrMod += global.party[targetSelected].weapon.str;
		} else {
			altStrMod = strMod;
		}
		
		var altDefMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altDefMod = itemArray[menuOption[page] + inventoryPage * 8].def;
			if (global.party[targetSelected].accessory != undefined) altDefMod += global.party[targetSelected].accessory.def;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altDefMod = itemArray[menuOption[page] + inventoryPage * 8].def;
			if (global.party[targetSelected].weapon != undefined) altDefMod += global.party[targetSelected].weapon.def;
		} else {
			altDefMod = defMod;
		}
		
		var altSpdMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altSpdMod = itemArray[menuOption[page] + inventoryPage * 8].spd;
			if (global.party[targetSelected].accessory != undefined) altSpdMod += global.party[targetSelected].accessory.spd;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altSpdMod = itemArray[menuOption[page] + inventoryPage * 8].spd;
			if (global.party[targetSelected].weapon != undefined) altSpdMod += global.party[targetSelected].weapon.spd;
		} else {
			altSpdMod = spdMod;
		}
		
		var altLuckMod = 0;
		if (page == menuPage.equipWeapon && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altLuckMod = itemArray[menuOption[page] + inventoryPage * 8].luck;
			if (global.party[targetSelected].accessory != undefined) altLuckMod += global.party[targetSelected].accessory.luck;
		} else if (page == menuPage.equipAccessory && menuOption[page] + inventoryPage * 8 < array_length(itemArray)) {
			altLuckMod = itemArray[menuOption[page] + inventoryPage * 8].luck;
			if (global.party[targetSelected].weapon != undefined) altLuckMod += global.party[targetSelected].weapon.luck;
		} else {
			altLuckMod = luckMod;
		}
		
		// Create strings and colors for stat display
		var maxHpInfo = calcStatText(page, maxHpMod, altHpMod, c2, c3, c6);
		var maxHpString = str(global.party[targetSelected].maxHp, maxHpInfo[1]);
		var maxHpColor = maxHpInfo[2];
		
		var maxMpInfo = calcStatText(page, maxMpMod, altMpMod, c2, c3, c6);
		var maxMpString = str(global.party[targetSelected].maxMp, maxMpInfo[1]);
		var maxMpColor = maxMpInfo[2];
		
		var mtvnInfo = calcStatText(page, mtvnMod, altMtvnMod, c2, c3, c6);
		var mtvnString = str(global.party[targetSelected].maxMtvn, mtvnInfo[1]);
		var mtvnColor = mtvnInfo[2];
		
		var strInfo = calcStatText(page, strMod, altStrMod, c2, c3, c6);
		var strString = str(global.party[targetSelected].str, strInfo[1]);
		var strColor = strInfo[2];
		
		var defInfo = calcStatText(page, defMod, altDefMod, c2, c3, c6);
		var defString = str(global.party[targetSelected].def, defInfo[1]);
		var defColor = defInfo[2];
		
		var spdInfo = calcStatText(page, spdMod, altSpdMod, c2, c3, c6);
		var spdString = str(global.party[targetSelected].spd, spdInfo[1]);
		var spdColor = spdInfo[2];
		
		var luckInfo = calcStatText(page, luckMod, altLuckMod, c2, c3, c6);
		var luckString = str(global.party[targetSelected].luck, luckInfo[1]);
		var luckColor = luckInfo[2];
		
		draw_text_color(startX+xBuffer, startY+yBuffer+6+3*(fontSize/2+yBuffer), "MAX HP: "+maxHpString, maxHpColor,maxHpColor,maxHpColor,maxHpColor,255);
		draw_text_color(startX+xBuffer, startY+yBuffer+6+4*(fontSize/2+yBuffer), "MAX MP: "+maxMpString, maxMpColor,maxMpColor,maxMpColor,maxMpColor,255);
		draw_text_color(startX+xBuffer, startY+yBuffer+6+5*(fontSize/2+yBuffer), "MOTIVATION: "+mtvnString, mtvnColor,mtvnColor,mtvnColor,mtvnColor,255);
		draw_text_color(startX+xBuffer, startY+yBuffer+6+6*(fontSize/2+yBuffer), "STR: "+strString, strColor,strColor,strColor,strColor,255);
		draw_text_color(startX+xBuffer, startY+yBuffer+6+7*(fontSize/2+yBuffer), "DEF: "+defString, defColor,defColor,defColor,defColor,255);
		draw_text_color(startX+xBuffer+140, startY+yBuffer+6+6*(fontSize/2+yBuffer), "SPD: "+spdString, spdColor,spdColor,spdColor,spdColor,255);
		draw_text_color(startX+xBuffer+140, startY+yBuffer+6+7*(fontSize/2+yBuffer), "LCK: "+luckString, luckColor,luckColor,luckColor,luckColor,255);
		
		// Draw EXP
		draw_rectangle_color(startX+xBuffer,startY+yBuffer+16+9*(fontSize/2+yBuffer),
							startX+width-xBuffer, startY+yBuffer+16+9.5*(fontSize/2+yBuffer), c5,c5,c5,c5, true);
		var xpRatio = global.party[targetSelected].xp / global.party[targetSelected].maxXp;
		draw_rectangle_color(startX+xBuffer,startY+yBuffer+16+9*(fontSize/2+yBuffer),
							startX+xBuffer+xpRatio*(width-2*xBuffer), startY+yBuffer+16+9.5*(fontSize/2+yBuffer), c5,c5,c5,c5, false);
		draw_set_font(fnt_textbox);
		draw_text_color(startX+xBuffer/2, startY+yBuffer+16+8*(fontSize/2+yBuffer), "LVL: "+string(global.party[targetSelected].level), c2,c2,c2,c2,255);
		draw_set_halign(fa_center);
		draw_set_font(fnt_textboxSmall);
		draw_text_color(startX + width/2,  startY+yBuffer+16+10*(fontSize/2+yBuffer),
					string(global.party[targetSelected].xp)+"\/"+string(global.party[targetSelected].maxXp), c2,c2,c2,c2,255);
					
		// Put arrow next to option selected
		if (page  == 6) {
			draw_sprite(spr_arrow, 0, startX+16, startY+yBuffer+6+(fontSize/2+yBuffer)*(menuOption[page]+1));
		}
		
		if (page == 12 || page == 13) {
			draw_rectangle_color(startX + width + 4, startY-4, 676, startY + 394, c2, c2, c2, c2, false);
			draw_rectangle_color(startX + width + 4, startY, 672, startY + 390, c1, c1, c1, c1, false);
			
			drawInventoryText(startX+width+4, startY, xBuffer, yBuffer, fontSize, inventoryPage, itemArray, page-11, c2);
			draw_sprite(spr_arrow, 0, startX+width+20, startY+menuOption[page]*(fontSize+yBuffer)+yBuffer+4);
		}
	}; break;
	
	case menuPage.equipSkill:
	case menuPage.skills : {
		// Draw the status
		drawStatus(startX, startY, fontSize, c1, c2, c3, c4, xBuffer, yBuffer, targetSelected);
		
		var width = 318;
		// Status rectangle
		draw_rectangle_color(startX-4, startY-4, startX + width + 4, startY + 394, c2, c2, c2, c2, false);
		draw_rectangle_color(startX, startY, startX + width, startY + 186, c1, c1, c1, c1, false);
		draw_rectangle_color(startX, startY + 190, startX + width, startY + 390, c1, c1, c1, c1, false);
		draw_text_color(startX+xBuffer/2, startY+yBuffer+4, "NAME: " + global.party[targetSelected].name, c2,c2,c2,c2,255);
		
		draw_set_font(fnt_textboxSmall);
		for (var i = 0; i < 4; i += 1) {
			if (i < array_length(global.party[targetSelected].skills)) {
				var skillName = global.party[targetSelected].skills[i].name
			} else {
				var skillName = "-------------";
			}
			draw_text_color(startX+xBuffer, startY+yBuffer+6+(i+1)*(fontSize/2+yBuffer), str("Skill ", i+1, ": ", skillName), c2,c2,c2,c2,255);
		}
		
		var skillDesc = "There is no description.";
		var skillMp = "";
		if (page == menuPage.skills) {
			// Put arrow next to option selected
			draw_sprite(spr_arrow, 0, startX+16, startY+yBuffer+6+(fontSize/2+yBuffer)*(menuOption[page]+1));
			if (menuOption[page] < array_length(global.party[targetSelected].skills)) {
				skillDesc = global.party[targetSelected].skills[menuOption[page]].desc;
				skillMp = "MP: " + string(global.party[targetSelected].skills[menuOption[page]].mpCost);
			}
		} else if (page == menuPage.equipSkill) {
			draw_rectangle_color(startX + width + 4, startY-4, 676, startY + 394, c2, c2, c2, c2, false);
			draw_rectangle_color(startX + width + 4, startY, 672, startY + 390, c1, c1, c1, c1, false);
			
			drawSkillsText(startX+width+4, startY, xBuffer, yBuffer, fontSize, targetSelected, c2);
			
			draw_sprite(spr_arrow, 0, startX+width+20, startY+menuOption[page]*(fontSize+yBuffer)+yBuffer+4);
			
			if (menuOption[page] + 8*inventoryPage < array_length(global.party[targetSelected].allSkills)) {
				skillDesc = global.party[targetSelected].allSkills[menuOption[page] + 8*inventoryPage].desc;
				skillMp = "MP: " + string(global.party[targetSelected].allSkills[menuOption[page] + 8*inventoryPage].mpCost);
			}
		}
		
		// Draw desc and mp cost
		draw_set_valign(fa_top);
		draw_set_font(fnt_textboxSmall)
		draw_text_ext_color(startX+xBuffer/2, startY+190+yBuffer/2, skillDesc, fontSize, width-xBuffer/2, c2, c2, c2, c2, 1);
		draw_set_halign(fa_right);
		draw_text_color(startX+width, startY+390-1.5*yBuffer, skillMp, c2, c2, c2, c2, 1);
	}; break;
}