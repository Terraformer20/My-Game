/// @description Main code

if (keyboard_check_pressed(vk_space)) print(global.deadAllies);
// Update motivation levels and associated multipliers
function updateMotivation() {
	var result = [];
	for (var i = 0; i < array_length(global.units); i += 1) {		
		var currMtvn = global.units[i].currStat.mtvn;
		var currMtvnLevel = global.units[i].myMtvnLevel;
		var maxMtvn = global.units[i].currStat.maxMtvn;
		
		if (currMtvn == 0 && currMtvnLevel != mtvnLevel.despair) {
			changeMtvnStats(global.units[i], 100/currMtvnLevel);
			changeMtvnStats(global.units[i], mtvnLevel.despair/100);
			global.units[i].myMtvnLevel = mtvnLevel.despair;
			array_push(result, [global.units[i].currStat.name, global.units[i].myMtvnLevel]);
			
		} else if (currMtvn > 0 && currMtvn <= .25*maxMtvn && currMtvnLevel != mtvnLevel.unmotivated) {
			changeMtvnStats(global.units[i], 100/currMtvnLevel);
			changeMtvnStats(global.units[i], mtvnLevel.unmotivated/100);
			global.units[i].myMtvnLevel = mtvnLevel.unmotivated;
			array_push(result, [global.units[i].currStat.name, global.units[i].myMtvnLevel]);
			
		} else if (currMtvn > .25*maxMtvn && currMtvn < .75*maxMtvn && currMtvnLevel != mtvnLevel.normal) {
			changeMtvnStats(global.units[i], 100/currMtvnLevel);
			global.units[i].myMtvnLevel = mtvnLevel.normal;
			array_push(result, [global.units[i].currStat.name, global.units[i].myMtvnLevel]);
			
		} else if (currMtvn >= .75*maxMtvn && currMtvn < maxMtvn && currMtvnLevel != mtvnLevel.motivated) {
			changeMtvnStats(global.units[i], 100/currMtvnLevel);
			changeMtvnStats(global.units[i], mtvnLevel.motivated/100);
			global.units[i].myMtvnLevel = mtvnLevel.motivated;
			array_push(result, [global.units[i].currStat.name, global.units[i].myMtvnLevel]);
			
		} else if (currMtvn == maxMtvn && currMtvnLevel != mtvnLevel.superMotivated) {
			changeMtvnStats(global.units[i], 100/currMtvnLevel);
			changeMtvnStats(global.units[i], mtvnLevel.superMotivated/100);
			global.units[i].myMtvnLevel = mtvnLevel.superMotivated;
			array_push(result, [global.units[i].currStat.name, global.units[i].myMtvnLevel]);
		}
	}
	return result;
}

function updateDeaths() {
	var result = [];
	for (var i = 0; i < array_length(global.units); i += 1) {
		if (global.units[i].currStat.hp <= 0 && !global.units[i].isDead) {
			global.units[i].isDead = true;
			
			// If the dead unit is an ally
			if (global.units[i].isAlly) {
				// Insert dead ally into array
				var currAllyIndex = indexOf(global.alliedUnits, global.units[i]);
				var insertIndex = 0;
				for (; insertIndex < array_length(global.deadAllies); insertIndex += 1) {
					if (indexOf(global.alliedUnits, global.deadAllies[insertIndex]) > currAllyIndex) {
						break;
					}
				}
				array_insert(global.deadAllies, insertIndex, global.units[i]);
				
				// Delete their move and remove from alive ally array
				array_delete(playerMoves, indexOf(global.aliveAllies, global.units[i]), 1);
				array_delete(global.aliveAllies, indexOf(global.aliveAllies, global.units[i]), 1);
			} else {
				// Remove any player moves that was targeting the dead person
				var tempMoves = [];
				for (var j = 0; j < array_length(playerMoves); j += 1) {
					if (playerMoves[j][2] != global.units[i]) {
						array_push(tempMoves, playerMoves[j])
					} else {
						playerMoves[j][1].turnFinished = true;
					}
				}
				playerMoves = tempMoves;
				
				// Add enemy to dead enemies and remove from alive ones
				array_push(global.deadEnemies, global.units[i]);
				array_delete(global.aliveEnemies, indexOf(global.aliveEnemies, global.units[i]), 1);
				// Hide sprite TODO play like a death animation
				global.units[i].image_alpha = 0;
			}
			array_push(result, global.units[i]);
		}
	}
	return result;
}

function nextTurn(allyTurn) {
	allyTurn += 1;
	for (; allyTurn < array_length(global.party); allyTurn += 1) {
		if (!global.alliedUnits[allyTurn].isDead) {
			break;
		}
	}
	return allyTurn;
}


switch (currPhase) {
	case battlePhase.init: {
		for (var i = 0; i < array_length(global.party); i += 1) {
			// Create a dummy object
			var currAlly = global.party[i];
			var unit = instance_create_depth(100 + 200*i, 500, 0, obj_ally);
			
			// Set stats
			unit.currStat = shallow_copy(currAlly);
			unit.baseStat = shallow_copy(unit.currStat);
			unit.currStat.mtvn = unit.currStat.maxMtvn / 2;
			
			// Add to appropriate lists
			array_push(global.units, unit);
			array_push(global.alliedUnits, unit);
			array_push(global.aliveAllies, unit);
			variable_struct_set(global.statTimer, unit, {});
		}
		for (var i = 0; i < array_length(global.enemies); i += 1) {
			// Create a dummy object
			var currEnemy = global.enemies[i];
			var unit = instance_create_depth(enemyPos[array_length(global.enemies)-1][i][0], enemyPos[array_length(global.enemies)-1][i][1], 0, obj_pUnit);
			if (!is_undefined(global.enemies[i].sprite)) unit.sprite_index = global.enemies[i].sprite;
			
			// TODO Set Stats
			unit.currStat = shallow_copy(currEnemy);
			unit.currStat.spd = irandom_range(currEnemy.rangeSpd[0], currEnemy.rangeSpd[1]);
			unit.currStat.mtvn = unit.currStat.maxMtvn / 2;
			unit.baseStat = shallow_copy(currEnemy);
			unit.baseStat.spd = unit.currStat.spd;
			
			// Add to appropriate lists
			array_push(global.units, unit);
			array_push(global.enemyUnits, unit);
			array_push(global.aliveEnemies, unit);
			variable_struct_set(global.statTimer, unit, {});
		}
		currPhase = battlePhase.startTurn;
	}; break;
	
	case battlePhase.startTurn: {
		global.units = bubbleSort(global.units);
		
		// Any start of turn effects
		createTextbox(352, 86, -10000, "Player's Turn To Act", self);
		playerMoves = [];
		currPhase = battlePhase.startWait;
	}; break;
	
	case battlePhase.playerTurn: {
		var optionChangeH = keyboard_check_pressed(global.rightKey) - keyboard_check_pressed(global.leftKey);
		var optionChangeV = keyboard_check_pressed(global.downKey) - keyboard_check_pressed(global.upKey);
		switch (currPage) {
			// Main page case
			case battlePage.main: {
				if (optionChangeH != 0 || optionChangeV != 0) {
					optionSelected[battlePage.main] = clamp(optionSelected[battlePage.main] + optionChangeH + 3*optionChangeV, 0, 4);
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;
			case battlePage.attack: {
				if (optionChangeH != 0 || optionChangeV != 0) {
					selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.aliveEnemies)-1);
					targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[selectIndex]);
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;
			case battlePage.skill: {
				if (optionChangeH != 0 || optionChangeV != 0) {
					optionSelected[battlePage.skill] = clamp(optionSelected[battlePage.skill] + optionChangeH + 2*optionChangeV, 0, 3);
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;
			case battlePage.item: {
				if (optionChangeH != 0 || optionChangeV != 0) {
					optionSelected[battlePage.item] += optionChangeH + 2*optionChangeV;
					if (optionSelected[battlePage.item] > 3) {
						inventoryPage = (inventoryPage + maxInventoryPage + 1) % maxInventoryPage
					} else if (optionSelected[battlePage.item] < 0) {
						inventoryPage = (inventoryPage + maxInventoryPage - 1) % maxInventoryPage
					}
					optionSelected[battlePage.item] = (optionSelected[battlePage.item] + 4) % 4;
					playUIAudio(snd_menu_optionsChange);
				}
			}; break;
			case battlePage.useItem:
			case battlePage.useSkill: {
				switch(currTargetType) {
					case targetType.selfTarget: {
						targetSelected = allyTurn;
					}; break;
					case targetType.singleTarget: {
						if (optionChangeH != 0 || optionChangeV != 0) {
							selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.aliveAllies)-1);
							targetSelected = indexOf(global.alliedUnits, global.aliveAllies[selectIndex]);
							playUIAudio(snd_menu_optionsChange);
						}
					}; break;
					case targetType.singleTargetEnemies: {
						if (optionChangeH != 0 || optionChangeV != 0) {
							selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.aliveEnemies)-1);
							targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[selectIndex]);
							playUIAudio(snd_menu_optionsChange);
						}
					}; break;
					case targetType.singleTargetAll: {
						if (optionChangeH != 0) {
							if (targetingAllies) {
								selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.aliveAllies)-1);
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[selectIndex]);
							} else {
								selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.aliveEnemies)-1);
								targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[selectIndex]);
							}
							playUIAudio(snd_menu_optionsChange);
						}
						if (optionChangeV != 0) {
							if (targetingAllies) {
								targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[0]);
							} else {
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[0]);
							}
							targetingAllies = !targetingAllies;
							selectIndex = 0;
						}
					}; break;
					case targetType.allTarget: {
						targetSelected = -2;
					}; break;
					case targetType.allTargetAll: {
						targetSelected = -3;
					}; break;
					case targetType.allTargetEnemies: {
						targetSelected = -2;
					}; break;
					case targetType.singleTargetDead: {
						selectIndex = clamp(selectIndex + optionChangeH, 0, array_length(global.deadAllies)-1);
						targetSelected = indexOf(global.alliedUnits, global.deadAllies[selectIndex]);
					}; break;
					case targetType.allTargetDead: {
						targetSelected = -4;
					}; break;
				}
			}; break;
		}
		
		if (keyboard_check_pressed(global.exitKey)) {
			switch(currPage) {
				case battlePage.main: {
					if (array_length(playerMoves) > 0) {
						var prevMove = array_pop(playerMoves);
						allyTurn = indexOf(global.alliedUnits, prevMove[1]);
						// If last action used an item readd it to the inventory
						if (prevMove[0] == global.skUseItem) {
							if (!ds_map_exists(global.inventory[0], prevMove[2])) {
								ds_map_set(global.inventory[0], prevMove[2], 0);
							}
							global.inventory[0][? prevMove[2]] += 1;
						}
					}
					if (alarm[9] == -1) alarm[9] = 1;
				} break;
				case battlePage.item:
				case battlePage.skill:
				case battlePage.attack: {
					optionSelected[currPage] = 0;
					currPage = battlePage.main;
					targetSelected = 0;
					selectIndex = 0;
				}; break;
				case battlePage.useSkill: {
					currPage = battlePage.skill;
					targetSelected = 0;
					selectIndex = 0;
				}; break;
				case battlePage.useItem: {
					currPage = battlePage.item;
					targetSelected = 0;
					selectIndex = 0;
				};
			}
			print(playerMoves);
		}
		
		if (keyboard_check_pressed(global.acceptKey)) {
			switch (currPage) {
				case battlePage.main: {
					if (optionSelected[battlePage.main] == 0) {
						currPage = battlePage.attack;
						targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[0]);
						selectIndex = 0;
					} else if (optionSelected[battlePage.main] == 1) {
						// TODO
						array_push(playerMoves, [global.skDefend, global.alliedUnits[allyTurn], global.alliedUnits[allyTurn]]);
						if (alarm[9] == -1) alarm[9] = 1;
						allyTurn = nextTurn(allyTurn);
						if (allyTurn > array_length(global.party)-1) {
							currPhase = battlePhase.priority;
						}
					} else if (optionSelected[battlePage.main] == 4) {
						array_push(playerMoves, [global.skRun, global.alliedUnits[allyTurn], global.enemyUnits[irandom(array_length(global.enemyUnits)-1)]]);
						if (alarm[9] == -1) alarm[9] = 1;
						allyTurn = nextTurn(allyTurn);
						if (allyTurn > array_length(global.party)-1) {
							currPhase = battlePhase.priority;
						}
					} else if (optionSelected[battlePage.main] == 2) {
						currPage = battlePage.skill;
					} else if (optionSelected[battlePage.main] == 3) {
						currPage = battlePage.item;
						inventoryPage = 0;
						var tempItemUpdate = updateItemArray(0, 4);
						maxInventoryPage = tempItemUpdate[0];
						itemArray = tempItemUpdate[1];
					}
				}; break;
				
				// Attack
				case battlePage.attack: {
					array_push(playerMoves, [global.skAttack, global.alliedUnits[allyTurn], global.enemyUnits[targetSelected]]);
					if (alarm[9] == -1) alarm[9] = 1;
					allyTurn = nextTurn(allyTurn);
					if (allyTurn > array_length(global.party)-1) {
						currPhase = battlePhase.priority;
					}
				}; break;
				
				// Select Skill
				case battlePage.skill: {
					var currSkills = global.party[allyTurn].skills;
					if (optionSelected[battlePage.skill] < array_length(currSkills) && global.alliedUnits[allyTurn].currStat.mp >= currSkills[optionSelected[battlePage.skill]].mpCost) {
						currTargetType = currSkills[optionSelected[battlePage.skill]].target;
						if (currTargetType == targetType.allTargetEnemies || currTargetType == targetType.singleTargetEnemies) {
							targetingAllies = false;
						} else {
							targetingAllies = true;
						}
						// Set starting target based on targetType
						switch(currTargetType) {
							case targetType.selfTarget: {
								targetSelected = allyTurn;
							}; break;
							case targetType.singleTarget: {
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[0]);
							}; break;
							case targetType.singleTargetEnemies: {
								targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[0]);
							}; break;
							case targetType.singleTargetAll: {
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[0]);
							}; break;
							case targetType.allTarget: {
								targetSelected = -2;
							}; break;
							case targetType.allTargetAll: {
								targetSelected = -3;
							}; break;
							case targetType.allTargetEnemies: {
								targetSelected = -2;
							}; break;
							case targetType.singleTargetDead: {
								if (array_length(global.deadAllies) > 0) {
									targetSelected = indexOf(global.alliedUnits, global.deadAllies[selectIndex]);
								} else {
									targetSelected = -1;
								}
							}; break;
							case targetType.allTargetDead: {
								targetSelected = -4;
							}; break;
						}
						currPage = battlePage.useSkill;
					} else {
						// Play a fail sound
					}
				}; break;
				
				// Use Skill
				case battlePage.useSkill: {
					if (targetingAllies && targetSelected >= 0) {
						array_push(playerMoves, [global.party[allyTurn].skills[optionSelected[battlePage.skill]], global.alliedUnits[allyTurn], global.alliedUnits[targetSelected]]);
					} else if (!targetingAllies && targetSelected >= 0) {
						array_push(playerMoves, [global.party[allyTurn].skills[optionSelected[battlePage.skill]], global.alliedUnits[allyTurn], global.enemyUnits[targetSelected]]);
					} else {
						array_push(playerMoves, [global.party[allyTurn].skills[optionSelected[battlePage.skill]], global.alliedUnits[allyTurn], global.alliedUnits[allyTurn]])
					}
					if (alarm[9] == -1) alarm[9] = 1;
					allyTurn = nextTurn(allyTurn);
					if (allyTurn > array_length(global.party)-1) {
						currPhase = battlePhase.priority;
					}
					currPage = battlePage.main;
				}; break;
				
				case battlePage.item: {
					var currIndex = optionSelected[battlePage.item] + 4*inventoryPage;
					if (currIndex < array_length(itemArray)) {
						var currItem = itemArray[currIndex];
						currTargetType = currItem.target;
						if (currTargetType == targetType.allTargetEnemies || currTargetType == targetType.singleTargetEnemies) {
							targetingAllies = false;
						} else {
							targetingAllies = true;
						}
						
						// Set starting target based on targetType
						switch(currTargetType) {
							case targetType.selfTarget: {
								targetSelected = allyTurn;
							}; break;
							case targetType.singleTarget: {
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[0]);
							}; break;
							case targetType.singleTargetEnemies: {
								targetSelected = indexOf(global.enemyUnits, global.aliveEnemies[0]);
							}; break;
							case targetType.singleTargetAll: {
								targetSelected = indexOf(global.alliedUnits, global.aliveAllies[0]);
							}; break;
							case targetType.allTarget: {
								targetSelected = -2;
							}; break;
							case targetType.allTargetAll: {
								targetSelected = -3;
							}; break;
							case targetType.allTargetEnemies: {
								targetSelected = -2;
							}; break;
							case targetType.singleTargetDead: {
								if (array_length(global.deadAllies) > 0) {
									targetSelected = indexOf(global.alliedUnits, global.deadAllies[selectIndex]);
								} else {
									targetSelected = -1;
								}
							}; break;
							case targetType.allTargetDead: {
								targetSelected = -4;
							}; break;
						}
						currPage = battlePage.useItem;
					} else {
						// Play fail sound
					}
				}; break;
				
				// TODO give it priority
				case battlePage.useItem: {
					var currIndex = optionSelected[battlePage.item] + 4*inventoryPage;
					var currItem = itemArray[currIndex];
					// Add the use item action
					if (targetingAllies && targetSelected >= 0) {
						array_push(playerMoves, [global.skUseItem, global.alliedUnits[allyTurn], global.alliedUnits[targetSelected], currItem]);
					} else if (!targetingAllies && targetSelected >= 0) {
						array_push(playerMoves, [global.skUseItem, global.alliedUnits[allyTurn], global.enemyUnits[targetSelected], currItem]);
					} else {
						array_push(playerMoves, [global.skUseItem, global.alliedUnits[allyTurn], global.alliedUnits[allyTurn], currItem]);
					}
					// Subtract item from inventory
					global.inventory[0][? currItem] -= 1;
					if (global.inventory[0][? currItem] <= 0) {
						ds_map_delete(global.inventory[0], currItem);
					}
					
					if (alarm[9] == -1) alarm[9] = 1;
					allyTurn = nextTurn(allyTurn);
					if (allyTurn > array_length(global.party)-1) {
						currPhase = battlePhase.priority;
					}
					currPage = battlePage.main;
				}; break;
			}
			print(playerMoves);
		}
	}; break;
	
	case battlePhase.priority: {
		for (var i = 0; i < array_length(playerMoves); i += 1) {
			// Can add more based on other priority moves
			if (playerMoves[i][0] == global.skDefend || playerMoves[i][0] == global.skRun || playerMoves[i][0] == global.skUseItem) {
				array_delete(global.units, indexOf(global.units, global.alliedUnits[i]), 1);
				array_insert(global.units, 0, global.alliedUnits[i]);
			}
		}
		currPhase = battlePhase.process;
	}; break;
	
	case battlePhase.process: {
		var combatStrings = [];
		
		for (var i = 0; i < array_length(global.units); i += 1) {
			if (!global.units[i].isDead && !global.units[i].turnFinished) {
				global.selectedUnit = global.units[i];
				global.selectedUnit.turnFinished = true;
				break;
			}
		}
		
		// Use Player Skill on Target
		if (global.selectedUnit.isAlly) {
			var allyNumber = indexOf(global.aliveAllies, global.selectedUnit);
			if (allyNumber != -1) {		
				var currMove = playerMoves[allyNumber][0];
				var currAlly = playerMoves[allyNumber][1];
				var currTarget = playerMoves[allyNumber][2];
				
				// If it is a skill TODO skills/items that target dead people
				if (currMove != global.skUseItem) {
					// Use the skill
					var moveVal = currMove.effect(currAlly, currTarget);
					var combatString = "";
					currAlly.currStat.mp = currAlly.currStat.mp - currMove.mpCost;
					
					// Special case skills string
					if (currMove == global.skAttack) {
						combatString = str(currAlly.currStat.name, " attacked ", currTarget.currStat.name, " dealing ", moveVal, " damage");
					} else if (currMove == global.skDefend) {
						combatString = str(currAlly.currStat.name, " defended")
					} else if (currMove == global.skRun) {
						combatString = str(currAlly.currStat.name, " tried to run and... ");
						if (moveVal == true) {
							combatString += "succeeded"
							global.run = true;
						} else {
							combatString += "failed"
							global.run = false;
						}
					} else {
						// First part of combatString
						switch(currMove.target) {
							case targetType.singleTargetAll:
							case targetType.singleTargetEnemies:
							case targetType.singleTarget: {
								combatString = str(currAlly.currStat.name, " used ", currMove.name, " on ", currTarget.currStat.name);
							}; break;
							default: {
								combatString = str(currAlly.currStat.name, " used ", currMove.name)
							}; break;
						}
						
						// Second part of combatString
						switch(currMove.skType) {
							case skillType.attack: {
								combatString += str(" dealing ", moveVal, " damage");
							}; break;
							case skillType.heal: {
								combatString += str(" healing ", moveVal, " health");
							}; break;
						}
					}
					// Add the string to the queue and play the animation TODO
					array_push(combatStrings, combatString+".")
				} else {
					var combatString = "";
					switch(playerMoves[allyNumber][3].target) {
						case targetType.singleTargetAll:
						case targetType.singleTargetEnemies:
						case targetType.singleTarget: {
							currMove.effect(playerMoves[allyNumber][2], playerMoves[allyNumber][3]);
							var combatString = str(currAlly.currStat.name, " used ", playerMoves[allyNumber][3].name, " on ", currTarget.currStat.name, ".");
						}; break;
						case targetType.allTarget: {
							for (var i = 0; i < array_length(global.aliveAllies); i += 1) {
								currMove.effect(global.aliveAllies[i], playerMoves[allyNumber][3]);
							}
							var combatString = str(currAlly.currStat.name, " used ", playerMoves[allyNumber][3].name, ".");
						}; break;
						case targetType.allTargetAll: {
							for (var i = 0; i < array_length(global.aliveAllies); i += 1) {
								currMove.effect(global.aliveAllies[i], playerMoves[allyNumber][3]);
							}
							for (var i = 0; i < array_length(global.aliveEnemies); i += 1) {
								currMove.effect(global.aliveEnemies[i], playerMoves[allyNumber][3]);
							}
							var combatString = str(currAlly.currStat.name, " used ", playerMoves[allyNumber][3].name, ".");
						}; break;
						case targetType.allTargetEnemies: {
							for (var i = 0; i < array_length(global.aliveEnemies); i += 1) {
								currMove.effect(global.aliveEnemies[i], playerMoves[allyNumber][3]);
							}
							var combatString = str(currAlly.currStat.name, " used ", playerMoves[allyNumber][3].name, ".");
						}; break;
					}
					array_push(combatStrings, combatString);
				}
			}
		} else {
			var combatString = "";
			var currEnemyStat = global.selectedUnit.currStat;
			var attackToUse = currEnemyStat.skills[irandom(array_length(currEnemyStat.skills)-1)];
			
			// Maybe have it based on game state in some way
			var targetAlly = currEnemyStat.targetFunction(global.selectedUnit, global.alliedUnits);
			var moveVal = attackToUse(global.selectedUnit, targetAlly);
			combatString = str(currEnemyStat.name, " attacked ", targetAlly.currStat.name, " dealing ", moveVal, " damage.");
			array_push(combatStrings, combatString);
		}
		
		// Update motivations and display it as text
		var mtvnUpdate = updateMotivation();
		for (var i = 0; i < array_length(mtvnUpdate); i += 1) {
			var temp = mtvnUpdate[i][0] + " is now ";
			switch(mtvnUpdate[i][1]) {
				case mtvnLevel.despair: temp += "despairing."; break;
				case mtvnLevel.unmotivated: temp += "unmotivated."; break;
				case mtvnLevel.normal: temp += "feeling normal."; break;
				case mtvnLevel.motivated: temp += "motivated."; break;
				case mtvnLevel.superMotivated: temp += "super motivated."; break;
			}
			array_push(combatStrings, temp);
		}
		
		// TODO
		var deathUpdate = updateDeaths();
		for (var i = 0; i < array_length(deathUpdate); i += 1) {
			array_push(combatStrings, deathUpdate[i].currStat.name + " has fallen.");
			// Do more stuff
		}
		
		// Create textbox of what just happened and display an animation for it
		createAutoTextbox(352, 86, -10000, combatStrings, self);
		currPhase = battlePhase.processWait;
	}; break;
	
	case battlePhase.checkFinish: {
		// Check if all enemies defeated
		var allDead = true;
		for (var i = 0; i < array_length(global.enemyUnits); i += 1) {
			if (!global.enemyUnits[i].isDead) {
				allDead = false;
				break;
			}
		}
		if (allDead) {
			currPhase = battlePhase.win;
			exit;
		}
		
		// Check if all allies defeated
		allDead = true;
		for (var i = 0; i < array_length(global.alliedUnits); i += 1) {
			if (!global.alliedUnits[i].isDead) {
				allDead = false;
				break;
			}
		}
		if (allDead) {
			createTextbox(352,352,-10000, "Looks like you weren't able to do anything after all.", self);
			currPhase = battlePhase.lose;
			exit;
		}
		
		// Check for if everyone's turn has passed
		for (var i = 0; i < array_length(global.units); i += 1) {
			if (!global.units[i].isDead && global.units[i].turnFinished == false) {
				currPhase = battlePhase.process;
				exit;
			}
		}
		currPhase = battlePhase.endTurn;
	}; break;
	
	// TODO
	case battlePhase.endTurn: {
		// Revert stat changes based on timers
		for (var i = 0; i < array_length(global.units); i += 1) {
			// Reset all unit's turnFinished
			global.units[i].turnFinished = false;
			
			// Stat changes timer
			var timerTemp = global.statTimer[$ global.units[i]];
			var statNames = variable_struct_get_names(timerTemp);
			for (var j = 0; j < array_length(statNames); j += 1) {
				var statTimers = timerTemp[$ statNames[j]];
				var replaceArray = [];
				print(statTimers);
				for (var k = 0; k < array_length(statTimers); k += 1) {
					if (statTimers[k][0] == 0) {
						variable_struct_set(global.units[i].currStat, statNames[j], statTimers[k][1](variable_struct_get(global.units[i].currStat, statNames[j])));
					} else {
						array_push(replaceArray, [statTimers[k][0]-1,  statTimers[k][1]]);
					}
				}
				variable_struct_set(timerTemp, statNames[j], replaceArray);
			}
		}
		currPhase = battlePhase.startTurn;
	}; break;
	
	case battlePhase.win: {
		var xpTotal = 0;
		var moneyTotal = 0;
		for (var i = 0; i < array_length(global.enemyUnits); i += 1) {
			if (is_array(global.enemyUnits[i].currStat.xp)) {
				xpTotal += irandom_range(global.enemyUnits[i].currStat.xp[0], global.enemyUnits[i].currStat.xp[1]);
			} else {
				xpTotal += global.enemyUnits[i].currStat.xp;
			}
			
			if (is_array(global.enemyUnits[i].currStat.money)) {
				xpTotal += irandom_range(global.enemyUnits[i].currStat.money[0], global.enemyUnits[i].currStat.money[1]);
			} else {
				moneyTotal += global.enemyUnits[i].currStat.money;
			}
		}
		var endStrings = ["YOU WIN!!!", str("The party gained ", xpTotal, " XP and $", moneyTotal, ".")];
		
		global.money += moneyTotal;
		for (var i = 0; i < array_length(global.alliedUnits); i += 1) {
			if (!global.alliedUnits[i].isDead)
				global.party[i].xp += xpTotal;
				
			if (global.party[i].xp >= global.party[i].maxXp) {
				// Handle level up stuff TODO
				global.party[i].level += 1;
				global.party[i].xp = global.party[i].xp % global.party[i].maxXp;
				
				// Get level up info based on character
				var currChar = noone;
				switch(indexOf(global.characters, global.party[i])) {
					case charNum.mc: currChar = global.levelUp.mc; break;
					case charNum.himiko: currChar = global.levelUp.himiko; break;
					case charNum.trevor: currChar = global.levelUp.trevor; break;
				}
				
				// Apply level up changes
				if (currChar != noone) {
					global.party[i].maxHp += currChar.maxHp[global.party[i].level];
					global.party[i].hp += currChar.maxHp[global.party[i].level];
					global.party[i].maxMp += currChar.maxMp[global.party[i].level];
					global.party[i].mp += currChar.maxMp[global.party[i].level];
					global.party[i].str += currChar.str[global.party[i].level];
					global.party[i].def += currChar.def[global.party[i].level];
					global.party[i].spd += currChar.spd[global.party[i].level];
					global.party[i].luck += currChar.luck[global.party[i].level];
					if (currChar.skill[global.party[i].level] != undefined) {
						array_push(global.party[i].allSkills, currChar.skill[global.party[i].level]);
						array_push(endStrings, str(global.party[i].name, " leveled up to level ", global.party[i].level, "!"));
						array_push(endStrings, str(global.party[i].name, " learned ", currChar.skill[global.party[i].level].name, "!"));
					} else {
						array_push(endStrings, str(global.party[i].name, " leveled up to level ", global.party[i].level, "!"));
					}
					global.party[i].maxXp += global.levelUp.xp[global.party[i].level];
				}
			}
		}
		createTextbox(352, 86, -10000, endStrings, self);
		currPhase = battlePhase.winWait;
	}; break;
}