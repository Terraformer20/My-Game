/// @description Insert description here
// You can write your code in this editor

var c1 = c_black;
var c2 = c_white;
var c3 = make_color_rgb(184, 24, 24);
var c4 = make_color_rgb(11, 48, 140);
var c5 = make_color_rgb(194, 156, 52);

// Draw status of specific character from bottom center coord
function drawStatus(startX, startY, charStat, selected) {
	// Set alignment and fonts
	draw_set_font(fnt_textbox);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	if (is_undefined(selected)) selected = false;
	var yBuffer = 15, xBuffer = 32;
	var fontSize = font_get_size(fnt_textbox); // 28 for fnt_textbox
	var c1 = c_black;
	if (charStat.hp <= 0) {
		selected = false;
		var c2 = c_gray;
		startY += 55;
	} else {
		var c2 = c_white;
	}
	var c3 = make_color_rgb(184, 24, 24);
	var c4 = make_color_rgb(11, 48, 140);
	var c5 = make_color_rgb(194, 156, 52);
	var width = 164;
	
	if (selected) startY = startY - 25;
	
	// Create the box and namebox
	draw_rectangle_color(startX-width/2-4, startY-204-fontSize/2, startX+width/2+4, startY, c2, c2, c2, c2, false);
	draw_rectangle_color(startX-width/2, startY-200-fontSize/2, startX+width/2, startY-200+fontSize, c1, c1, c1, c1, false);
	draw_rectangle_color(startX-width/2, startY-196+fontSize, startX+width/2, startY-4, c1, c1, c1, c1, false);
	draw_text_ext_color(startX-width/2+10, startY-200, charStat.name, xBuffer, 163, c2, c2, c2, c2, 255);
	
	draw_set_font(fnt_textboxSmall);
	
	// Draw health bar
	var barStart = startY-196+fontSize+yBuffer;
	var maxHp = charStat.maxHp;
	
	var hpRatio = charStat.hp/maxHp;
	draw_rectangle_color(startX-width/2+10, barStart, startX+width/2-10, barStart+35, c3, c3, c3, c3, true);
	draw_rectangle_color(startX-width/2+10, barStart, startX-width/2+10+hpRatio*(width-20), barStart+35, c3, c3, c3, c3, false);
	draw_text_color(startX-width/2+15, barStart+18, "HP:"+string(charStat.hp)+"\/"+string(maxHp),c2,c2,c2,c2,255);
	
	// Draw MP Bar
	barStart = startY-196+fontSize+yBuffer*2+35;
	var maxMp = charStat.maxMp;
	
	var mpRatio = charStat.mp/maxMp;
	draw_rectangle_color(startX-width/2+10, barStart, startX+width/2-10, barStart+35, c4, c4, c4, c4, true);
	draw_rectangle_color(startX-width/2+10, barStart, startX-width/2+10+mpRatio*(width-20), barStart+35, c4, c4, c4, c4, false);
	draw_text_color(startX-width/2+15, barStart+18, "MP:"+string(charStat.mp)+"\/"+string(maxMp),c2,c2,c2,c2,255);
	
	// Draw MTVN Bar
	barStart = startY-196+fontSize+yBuffer*3+35*2;
	var maxMtvn = charStat.maxMtvn;
	
	var mtvnRatio = charStat.mtvn/maxMtvn;
	draw_rectangle_color(startX-width/2+10, barStart, startX+width/2-10, barStart+35, c5, c5, c5, c5, true);
	draw_rectangle_color(startX-width/2+10, barStart, startX-width/2+10+mtvnRatio*(width-20), barStart+35, c5, c5, c5, c5, false);
	draw_text_color(startX-width/2+15, barStart+18, "MTVN:"+string(charStat.mtvn)+"\/"+string(maxMtvn),c2,c2,c2,c2,255);
}

if (currPhase == battlePhase.lose) exit;

// Draw Statuses
var numParty = array_length(global.party);
var width = 164;
var space = 704-width*numParty;
for (var i = 0; i < numParty; i += 1) {
	if (i == allyTurn || i == -2) {
		drawStatus(space/(numParty+1)*(i+1)+width*i+width/2, 704, global.alliedUnits[i].currStat, true);
	} else {
		drawStatus(space/(numParty+1)*(i+1)+width*i+width/2, 704, global.alliedUnits[i].currStat, false);
	}
}

draw_text_color(5,0, "selected unit: "+string(global.selectedUnit)+", combat phase: "+string(currPhase), c_white,c_white,c_white,c_white,255);

for (var i = 0; i < array_length(global.units); i += 1) {
	draw_text_color(5,16+16*i, string(global.units[i].id), c_white,c_white,c_white,c_white,255);
}

draw_set_font(fnt_textbox);
draw_sprite(spr_textbox_writing, 0, 352, 86);
switch(currPhase) {
	case battlePhase.playerTurn: {
		switch (currPage) {
			// Main menu case
			case battlePage.main: {
				var tempOptions = ["ATTACK", "DEFEND", "SKILL", "ITEM", "RUN"];
				var tempLen = array_length(tempOptions);
				for (var i = 0; i < tempLen; i += 1) {
					draw_text_color(64+640/3*(i%3), 57*(floor(i/3) + 1), tempOptions[i],c2,c2,c2,c2,255);
				}
				draw_sprite(spr_arrow, 0, 48+640/3*(optionSelected[battlePage.main]%3), 57*(floor(optionSelected[battlePage.main]/3) + 1) + 3);
			}; break;
			
			// Attack selection case
			case battlePage.attack: {
				draw_text_color(64, 86, "Who to attack?",c2,c2,c2,c2,255);
				draw_sprite(spr_arrowUp, 0, enemyPos[array_length(global.enemies)-1][targetSelected][0], enemyPos[array_length(global.enemies)-1][targetSelected][1]+8);
			}; break;
			
			// Skills selection case
			case battlePage.skill: {
				var allySkills = global.party[allyTurn].skills;
				for (var i = 0; i < 4; i += 1) {
					if (i  < array_length(allySkills)) {
						draw_text_color(64+640/2*(i%2), 57*(floor(i/2)+1), allySkills[i].name,c2,c2,c2,c2,1);
						draw_set_halign(fa_right);
						draw_set_font(fnt_textboxSmall);
						draw_text_color(640/2*(i%2+1), 57*(floor(i/2)+1), str("MP: ", allySkills[i].mpCost),c2,c2,c2,c2,1);
						draw_set_halign(fa_left);
						draw_set_font(fnt_textbox);
						draw_line_color(64+640/2*(i%2), 57*(floor(i/2)+1)+20, 640/2*(i%2+1), 57*(floor(i/2)+1)+20, c2, c2);
					} else {
						draw_text_color(64+640/2*(i%2), 57*(floor(i/2)+1), "-----------------",c2,c2,c2,c2,1);
					}
				}
				draw_sprite(spr_arrow, 0, 48+640/2*(optionSelected[battlePage.skill]%2), 57*(floor(optionSelected[battlePage.skill]/2)+1));
			}; break;
			
			case battlePage.item: {
				for (var i = 0; i < 4; i += 1) {
					if (i + 4*inventoryPage < array_length(itemArray)) {
						var currItem = itemArray[i + 4*inventoryPage];
						draw_text_color(64+640/2*(i%2), 57*(floor(i/2)+1), currItem.name,c2,c2,c2,c2,1);
						draw_set_halign(fa_right);
						draw_set_font(fnt_textboxSmall);
						draw_text_color(640/2*(i%2+1), 57*(floor(i/2)+1), str("x", global.inventory[0][? currItem]),c2,c2,c2,c2,1);
						draw_set_halign(fa_left);
						draw_set_font(fnt_textbox);
						draw_line_color(64+640/2*(i%2), 57*(floor(i/2)+1)+20, 640/2*(i%2+1), 57*(floor(i/2)+1)+20, c2, c2);
					} else {
						draw_text_color(64+640/2*(i%2), 57*(floor(i/2)+1), "-----------------",c2,c2,c2,c2,1);
					}
				}
				draw_sprite(spr_arrow, 0, 48+640/2*(optionSelected[battlePage.item]%2), 57*(floor(optionSelected[currPage]/2)+1));
			}; break;
			
			// Use Skill case
			case battlePage.useItem: 
			case battlePage.useSkill: {
				if (currPage == battlePage.useSkill) {
					var allySkills = global.party[allyTurn].skills;
					draw_text_ext_color(32, 32, allySkills[optionSelected[battlePage.skill]].desc, 48, 672,c2,c2,c2,c2,1);
					draw_set_halign(fa_right);
					draw_text_color(672, 144, str("MP: ", allySkills[optionSelected[battlePage.skill]].mpCost),c2,c2,c2,c2,1);
					draw_set_halign(fa_left);
				} else if (currPage == battlePage.useItem) {
					// Display item usage desc
					draw_text_ext_color(32, 32, itemArray[optionSelected[battlePage.item]].effectDescription, 48, 672,c2,c2,c2,c2,1);
				}
				
				if (targetSelected == -3) {
					// Draw an arrow on everybody alive
					for (var i = 0; i < array_length(global.enemyUnits); i += 1) {
						if (!global.enemyUnits[i].isDead)
							draw_sprite(spr_arrowUp, 0, enemyPos[array_length(global.enemies)-1][i][0], enemyPos[array_length(global.enemies)-1][i][1]+8);
					}
					for (var i = 0; i < numParty; i += 1) {
						if (i == allyTurn) {
							draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(i+1)+width*i+width/2, 449);
						} else if (!global.alliedUnits[i].isDead) {
							draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(i+1)+width*i+width/2, 474);
						}
					}
				} else if (targetSelected == -4){
					// TODO Draw an arrow on everybody dead
				} else if (targetingAllies) {
					// Draw an arrow over ally(ies) alive
					if (targetSelected == -2) {
						for (var i = 0; i < numParty; i += 1) {
							if (i == allyTurn) {
								draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(i+1)+width*i+width/2, 449);
							} else if (!global.alliedUnits[i].isDead) {
								draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(i+1)+width*i+width/2, 474);
							}
						}
					} else if (targetSelected == allyTurn) {
						draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(targetSelected+1)+width*targetSelected+width/2, 449);
					} else {
						draw_sprite(spr_arrowDown, 0, space/(numParty+1)*(targetSelected+1)+width*targetSelected+width/2, 474);
					}
				} else {
					// Draw an arrow over enemy(ies) selected
					if (targetSelected == -2) {
						for (var i = 0; i < array_length(global.enemyUnits); i += 1) {
							if (!global.enemyUnits[i].isDead)
								draw_sprite(spr_arrowUp, 0, enemyPos[array_length(global.enemies)-1][i][0], enemyPos[array_length(global.enemies)-1][i][1]+8);
						}
					} else {
						draw_sprite(spr_arrowUp, 0, enemyPos[array_length(global.enemies)-1][targetSelected][0], enemyPos[array_length(global.enemies)-1][targetSelected][1]+8);
					}
				}
			}; break;
		}
	}; break;
}
